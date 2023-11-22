import numpy as np

Instructions = {
    # Aritmeticas Escalares
    "sub":{"opType":"art", "opcode":0},
    "add":{"opType":"art", "opcode":1},
    "mul":{"opType":"art", "opcode":2},
    "mov":{"opType":"art", "opcode":3},
    "cmp":{"opType":"art", "opcode":4},
    "div":{"opType":"art", "opcode":5},
    "xor":{"opType":"art", "opcode":6},
    "and":{"opType":"art", "opcode":7},
    "not":{"opType":"art", "opcode":8},
    "mod":{"opType":"art", "opcode":9},
    # Aritmeticas Vectoriales
    "movv":{"opType":"art", "opcode":10},
    "senv":{"opType":"art", "opcode":11},
    "cosv":{"opType":"art", "opcode":12},
    "addv":{"opType":"art", "opcode":13},
    "multv":{"opType":"art", "opcode":14},
    "divv":{"opType":"art", "opcode":15},

    # Operaciones de memoria escalares
    "ld":{"opType":"mem", "opcode":0},
    "str":{"opType":"mem", "opcode":1},
    # Operaciones de memoria vectoriales
    "ldv":{"opType":"mem", "opcode":2},
    "strv":{"opType":"mem", "opcode":3},

    #Operaciones de control de flujo
    "b":{"opType":"cont", "opcode":0},
    "beq":{"opType":"cont", "opcode":1},
    "bne":{"opType":"cont", "opcode":2},
    "ble":{"opType":"cont", "opcode":3},
    "bg":{"opType":"cont", "opcode":4},
    }

functions = {}
branchLine = 0
actualInstruction = 0
instructionResult = []

# Abrir archivo con el codigo en ensamblador
def openFile():
    #f = open("Software/main.txt", "r")
    f = open("input.s", "r")
    counter = 0
    for line in f:
        if not line.isspace():
            try:
                AnalyzeLine(line.lower(), counter)
            except:
                
                print(f"###################\n###################\nException in line {counter}\n{line}\n###################\n###################\n")
        
        counter += 1
  
    SetBranches()
    f.close()

    CreateFile()

def AnalyzeLine(line, counter):
    global branchLine
    global actualInstruction
    line = line.strip()
    # Nuevo Branch
    if ":" in line:
        name = line.replace(":","")
        functions[name] = branchLine
        
    # 
    elif(line != ""):
        print("linea es:", line)
        lineElements = line.split(" ",1)
        registers = GetRegistersInList(lineElements[1])
        GetFunction(lineElements[0], registers)
        actualInstruction += 1
        branchLine += 1

def GetFunction(functionText, registersList):
    result = Instructions.get(functionText)
    code = ""
    #If operation es aritmethic
    if(result.get("opType") == "art"):
        flag =  IsInmediate(registersList[len(registersList)-1])
        
        code += "01" if flag else "00"
        opcode = format(result.get("opcode"), 'b')
        while (len(opcode) < 4): opcode = "0"+opcode
        code += opcode
        if(functionText == "cmp" or functionText == "mov" or functionText == "not" or functionText == "movv"): #It's an op of 2 operands
            if(functionText == "cmp"):
                code += GetAllRegistersOpcode("r0", registersList[0] ,registersList[1]) 
            else:   
                code += GetAllRegistersOpcode(registersList[0], "r0" ,registersList[1])
        else:
            code += GetAllRegistersOpcode(registersList[0], registersList[1], registersList[2])
    #If operation is Memory
    elif(result.get("opType") == "mem"):
        code += "1000"
        #If operation is load add 0, else is a store operation and add 1
        if(functionText == "ld"):
            code += "00"
        elif(functionText == "str"):
            code += "01"
        elif(functionText == "ldv"):
            code += "10"
        elif(functionText == "strv"):
            code += "11" 
        else: 
            print("Funcion de memoria no reconocida")
        
        if(len(registersList) == 2):
            code += GetAllRegistersOpcode(registersList[0],"r0", registersList[1])
        else: 
            code += GetAllRegistersOpcode(registersList[0], registersList[1], registersList[2])
    elif(result.get("opType") == "cont"):
        code += "110"
        opcode = format(result.get("opcode"), 'b')
        while (len(opcode) < 3): opcode = "0"+opcode
        code += opcode
        code += "0" * 8
        code += "=" + registersList[0]
    instructionResult.append(code)
    print(code)

# Returns registers in a list
def GetRegistersInList(registersString):
    registersString = registersString.replace(" ","")
    registers = registersString.split(",")
    return registers

def IsInmediate(register3):
    flag = False
    if("#" in register3):
        flag = True
    return flag

def GetAllRegistersOpcode(register1, register2, register3): 
    flag = IsInmediate(register3)
    reg1 = GetRegisterOpcode(register1)
    reg2 = GetRegisterOpcode(register2)
    reg3 = ""
    if(flag):
        registerNumber = register3.replace("#","")
        registerNumber = int(registerNumber)
        reg3Aux = format(registerNumber, 'b')
        #print("Int is: ", registerNumber)
        #print("reg3Aux is: ", reg3Aux)
        #print("reg3 is: ", reg3)
        reg3 = negative_to_twos_complement(int(reg3Aux,2),18)
        
    else:
        reg3 = GetRegisterOpcode(register3)
        reg3 += "0" * 14
    result = reg1 + reg2 + reg3
    return result

def GetRegisterOpcode(register):
    registerNumber = register.replace("r","")
    registerNumber = int(registerNumber)
    binary = format(registerNumber, 'b')
    counter = len(binary)
    while(counter < 4):
        binary = "0" + binary
        counter += 1
    return binary

def SetBranches():
    branchLine = 0
    print("------")
    #print(instructionResult)
    print(functions)
    print("------")
    for branch in instructionResult:
        
        if( "=" in branch):
            pcRelative = 0
              
            newInstruction = branch[:branch.find("=")]
            branchLabel = branch[branch.find("=") + 1 :]
            #print("Instruccion ",newInstruction)
            #print("Branch Label ",branchLabel)

            jump = functions.get(branchLabel)
            
            actualInstructionAux = branchLine
            
            print("-------------")
            print("Pc Relative (A donde quiero saltar): ", jump)
            
            print("Actual Line (En donde invoco el salto): ", branchLine)
            print("-------------") 

            if(jump > branchLine):
                while(jump > actualInstructionAux):
                    pcRelative += 4
                    actualInstructionAux += 1
            elif(jump < actualInstructionAux):
                while(jump < actualInstructionAux):
                    pcRelative -= 4
                    actualInstructionAux -= 1

            resultAux = format(pcRelative, 'b')
            print("PC Relative despues de formatear: ", int(resultAux, 2))
            result = negative_to_twos_complement(int(resultAux, 2), 18)
            print("PC Relative despues del complemento a 2: ", result)
            instructionResult[branchLine] = newInstruction + result
            print("Branch code result: ", instructionResult[branchLine])
        branchLine += 1
    return ""

def CreateFile():
    #with open('microarchitecture\instructionMemory.mem', 'w') as f:
    with open('instructionMemory.mem', 'w') as f:
        counter = 0
        for line in instructionResult:
            hexadecimal = ConvertToHex(line)
            f.writelines(hexadecimal[6:8]+"\n"+hexadecimal[4:6]+"\n"+hexadecimal[2:4]+"\n"+hexadecimal[0:2]+"\n")
            counter += 4
        while(counter < 16384):
            f.writelines("00\n")
            counter += 1
    f.close()

def ConvertToHex(binaryNumber):
    hexNumber = hex(int(binaryNumber,2))
    hexNumberSplit = hexNumber.split("x")
    hexNumber = hexNumberSplit[1]
    counter = len(hexNumber)
    while (counter < 8):
        hexNumber = "0" +hexNumber
        counter += 1
    return hexNumber

def negative_to_twos_complement(number, num_bits):
    if (number<0):
        # Convertir el número negativo a su valor absoluto
        abs_number = abs(number)

        # Representar el número en binario
        binary = bin(abs_number)[2:].zfill(num_bits)

        # Invertir los bits
        inverted_bits = ''.join('1' if bit == '0' else '0' for bit in binary)

        # Sumar 1 al número invertido
        twos_complement = np.binary_repr(int(inverted_bits, 2) + 1, width=num_bits)

        return twos_complement
    else:
        binary = bin(number)[2:].zfill(num_bits)
        return binary
    
openFile()