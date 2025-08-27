import Foundation

// MARK: - Game State
class GameState {
    var playerName: String = ""
    var hackingLevel: Int = 1
    var reputation: Int = 0
    var money: Int = 100
    var currentTarget: String = ""
    var isInSystem: Bool = false
    var discoveredSystems: [String] = []
    var completedMissions: [String] = []
    var shopSelect: Int = 0
    var inventory: [String] = []
    
    func displayStats() {
        print("\n=== HACKER PROFILE ===")
        print("Handle: \(playerName)")
        print("Level: \(hackingLevel)")
        print("Reputation: \(reputation)")
        print("Credits: $\(money)")
        print("Systems Compromised: \(discoveredSystems.count)")
        print("=====================\n")
    }
}

// MARK: - Game Engine
class HackerGame {
    private let gameState = GameState()
    private var isRunning = true
    
    private let availableTargets = [
        "corporate-server-001.megacorp.com",
        "banking-system.firstbank.net",
        "government-db.agency.gov",
        "university-network.edu",
        "hospital-records.medcenter.org",
        "metacortex.co.uk",
        "okinaoshiri.co.jp"
    ]
    
    private let hackingCommands = [
        "scan", "nmap", "exploit", "crack", "backdoor", "download", 
        "upload", "delete", "trace", "proxy", "decrypt", "bruteforce","ddos"
    ]
    
    func start() {
        displayBanner()
        setupPlayer()
        gameLoop()
    }
    
    private func displayBanner() {
        print("""
        ╔═══════════════════════════════════════════════════════════╗
        ║                    HAXX                                   ║
        ║                                                           ║
        ║               HACK THE PLANET                             ║
        ║                                                           ║
        ║         Type 'help' for available commands                ║
        ╚═══════════════════════════════════════════════════════════╝
        """)
    }
    
    private func setupPlayer() {
        print("\nEnter your hacker handle: ", terminator: "")
        if let handle = readLine(), !handle.isEmpty {
            gameState.playerName = handle
        } else {
            gameState.playerName = "Anonymous"
        }
        
        print("\nWelcome to the general access server, \(gameState.playerName)...")
        print("")
        gameState.displayStats()
    }
    
    private func gameLoop() {
        while isRunning {
            displayPrompt()
            
            guard let input = readLine()?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) else {
                continue
            }
            
            processCommand(input)
        }
    }
    
    private func displayPrompt() {
        let prompt = gameState.isInSystem ? "[\(gameState.currentTarget)]$ " : "bsd@terminal:~$ "
        print(prompt, terminator: "")
    }
    
    private func processCommand(_ command: String) {
        let parts = command.split(separator: " ")
        guard let mainCommand = parts.first else { return }
        
        switch String(mainCommand) {
        case "help":
            showHelp()
        case "stats", "status":
            gameState.displayStats()
        case "scan":
            scanForTargets()
        case "connect", "ssh":
            if parts.count > 1 {
                connectToTarget(String(parts[1]))
            } else {
                print("Usage: connect <target>")
            }
        case "nmap":
            performNmap()
        case "exploit":
            attemptExploit()
        case "crack":
            if parts.count > 1 {
                crackPassword(String(parts[1]))
            } else {
                crackPassword()
            }
        case "download":
            downloadFiles()
        case "ddos":
            ddos()
        case "backdoor":
            installBackdoor()
        case "disconnect", "exit":
            if gameState.isInSystem {
                disconnectFromTarget()
            } else {
                exitGame()
            }
        case "missions":
            showMissions()
        case "mission1":
            missionOne()
        case "mission2":
            missionTwo()
        case "mission3":
            missionThree()
        case "mission4":
            missionFour()
        case "mission5":
            missionFive()
        case "shop":
            showShop()
        case "clear":
            clearScreen()
        default:
            if gameState.isInSystem {
                simulateSystemCommand(command)
            } else {
                print("Unknown command. Type 'help' for available commands.")
            }
        }
    }
    
    private func showHelp() {
        print("""
        
        === AVAILABLE COMMANDS ===
        help          - Show this help menu
        stats         - Display your hacker profile
        scan          - Scan for available targets
        connect <ip>  - Connect to a target system
        nmap          - Port scan current target
        exploit       - Attempt to exploit vulnerabilities
        crack [type]  - Crack passwords (ssh, ftp, admin)
        download      - Download sensitive files
        backdoor      - Install persistent backdoor
        disconnect    - Disconnect from current system
        missions      - View available missions
        shop          - Visit the server marketplace
        clear         - Clear the terminal
        exit          - Exit the game
        
        === SYSTEM COMMANDS (when connected) ===
        ls, dir       - List files
        cat <file>    - View file contents
        rm <file>     - Delete files
        ps            - Show running processes
        netstat       - Show network connections
        whoami        - Current user info
        """)
    }
    
    private func scanForTargets() {
        print("\nScanning the web for targets...")
        simulateProgress()
        
        print("\n=== AVAILABLE TARGETS ===")
        for (index, target) in availableTargets.enumerated() {
            let status = gameState.discoveredSystems.contains(target) ? "[COMPROMISED]" : "[SECURE]"
            print("\(index + 1). \(target) \(status)")
        }
        print("========================\n")
    }
    

    private func connectToTarget(_ target: String) {
        let fullTarget = target.contains(".") ? target : availableTargets.first { $0.contains(target) } ?? target
        
        print("Attempting to connect to \(fullTarget)...")
        simulateProgress()
        
        if Int.random(in: 1...10) > 3 {
            gameState.currentTarget = fullTarget
            gameState.isInSystem = true
            print("Connection established!")
            print("You are now connected to \(fullTarget)")
            print("Type 'help' to see available commands.")
        } else {
            print("Connection failed. Target may be protected or offline.")
        }
    }
    
    private func ddos(){
        guard gameState.isInSystem else {
            print("No targets specified")
            return
        }
        print("Initializing Botnet...")
        simulateProgress()
        print("Botnet active. Sending Requests...")
        simulateProgress()
        let success = Int.random(in: 1...10) > 3
        if success {
            print("Pinging target...")
            simulateProgress()
            print("target offline and non-responsive to pings")
            gameState.reputation += 5
        } else{
            print("Target traffic likely filtered")
        }
    }
    
    private func performNmap() {
        guard gameState.isInSystem else {
            print("You need to connect to a target first.")
            return
        }
        
        print("Running nmap scan on \(gameState.currentTarget)...")
        simulateProgress()
        
        let ports = ["22/tcp ssh", "80/tcp http", "443/tcp https", "21/tcp ftp", "3389/tcp rdp"]
        let openPorts = ports.shuffled().prefix(Int.random(in: 2...4))
        
        print("\nOpen ports discovered:")
        for port in openPorts {
            print("  \(port) - OPEN")
        }
        print("")
    }
    
    private func attemptExploit() {
        guard gameState.isInSystem else {
            print("You need to connect to a target first.")
            return
        }
        
        print("Searching for exploitable vulnerabilities...")
        simulateProgress()
        
        let success = Int.random(in: 1...10) > (5 - gameState.hackingLevel)
        
        if success {
            print("Vulnerability found! Exploiting buffer overflow in SSH service...")
            simulateProgress()
            print("Root access gained!")
            gameState.reputation += 10
            gameState.money += 50
            
            if !gameState.discoveredSystems.contains(gameState.currentTarget) {
                gameState.discoveredSystems.append(gameState.currentTarget)
            }
        } else {
            print("No exploitable vulnerabilities found. System appears to be patched.")
        }
    }
    
    private func crackPassword(_ type: String = "admin") {
        guard gameState.isInSystem else {
            print("You need to connect to a target first.")
            return
        }
        
        print("Initiating brute force attack on \(type) password...")
        simulateProgress(duration: 3)
        
        let passwords = ["password123", "admin", "123456", "qwerty", "letmein", "password"]
        let crackedPassword = passwords.randomElement()!
        
        let success = Int.random(in: 1...10) > 4
        
        if success {
            print("Password cracked! \(type): \(crackedPassword)")
            gameState.reputation += 5
            gameState.money += 25
        } else {
            print("Brute force attack failed. Account may be locked.")
        }
    }
    
    private func downloadFiles() {
        guard gameState.isInSystem else {
            print("You need to connect to a target first.")
            return
        }
        
        let files = ["financial_records.db", "user_passwords.txt", "classified_docs.pdf", 
                    "source_code.zip", "customer_data.csv"]
        let targetFile = files.randomElement()!
        
        print("Downloading \(targetFile)...")
        simulateProgress(duration: 2)
        
        let success = Int.random(in: 1...10) > 3
        
        if success {
            print("Download complete! File saved to secure partition.")
            gameState.reputation += 15
            gameState.money += 100
        } else {
            print("Download interrupted. File may be corrupted or protected.")
        }
    }
    
    private func installBackdoor() {
        guard gameState.isInSystem else {
            print("You need to connect to a target first.")
            return
        }
        
        print("Installing persistent backdoor...")
        simulateProgress(duration: 2)
        
        let success = Int.random(in: 1...10) > 4
        
        if success {
            print("Backdoor installed successfully!")
            print("You now have permanent access to this system.")
            gameState.reputation += 20
            gameState.hackingLevel += 1
        } else {
            print("Backdoor installation failed. Antivirus may have detected it.")
        }
    }
    
    private func simulateSystemCommand(_ command: String) {
        let parts = command.split(separator: " ")
        guard let cmd = parts.first else { return }
        
        switch String(cmd) {
        case "ls", "dir":
            print("total 42")
            print("drwxr-xr-x  admin  admin  4096 Dec 25 13:37 documents")
            print("-rw-r--r--  admin  admin  1024 Dec 25 13:35 passwords.txt")
            print("-rw-r--r--  admin  admin  2048 Dec 25 13:30 financial_data.db")
            print("drwxr-xr-x  admin  admin  4096 Dec 25 13:25 backup")
            
        case "cat":
            if parts.count > 1 {
                let filename = String(parts[1])
                print("Displaying contents of \(filename):")
                if filename.contains("password") {
                    print("admin:$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi")
                    print("user:$2y$10$TKh8H1.PfQx37YgCzwiKb.KjNyWgaHb9cbcoQgdIVFlYg7B77UdFm")
                } else {
                    print("[ENCRYPTED DATA - REQUIRES DECRYPTION KEY]")
                }
            }
            
        case "ps":
            print("PID  PPID CMD")
            print("1    0    /sbin/init")
            print("123  1    sshd: admin@pts/0")
            print("456  1    apache2")
            print("789  1    mysql")
            
        case "whoami":
            print("root")
            
        case "netstat":
            print("Active connections:")
            print("tcp  0.0.0.0:22    LISTEN")
            print("tcp  0.0.0.0:80    LISTEN")
            print("tcp  0.0.0.0:443   LISTEN")
            
        default:
            print("bash: \(command): command not found")
        }
    }
    
    private func disconnectFromTarget() {
        print("Disconnecting from \(gameState.currentTarget)...")
        gameState.isInSystem = false
        gameState.currentTarget = ""
        print("Connection closed. Back to the open web.")
    }
    
    private func showMissions() {
        print("""
        
        === AVAILABLE MISSIONS ===
        1. Corporate Espionage - Steal trade secrets ($500)
        2. Bank Heist - Transfer funds anonymously ($1000)
        3. Government Leak - Expose classified documents ($750)
        4. Ransomware Deploy - Encrypt hospital systems ($300)
        5. Identity Theft - Harvest personal data ($200)
        
        [Missions are simulated for educational purposes only]
        """)
    }
    
    private func showShop() {
        print("""
        
        === SERVER MARKETPLACE ===
        1. Advanced Exploit Kit - $200
        2. Zero-Day Vulnerability - $500
        3. Botnet Access - $300
        4. Encrypted VPN - $100
        5. Identity Spoofing Package - $150
        
        Your Credits: $\(gameState.money)
        [Type 'buy <item>' to purchase]
        """)
        //buyFromShop(selection)
    }
    
    
    private func buyFromShop(selection:Int){
     switch Int(selection) {
     case 1:
         print("Advanced Exploit Kit purchased")
         simulateProgress()
         //add item to players inventory. probably by using an array.
         gameState.money -= 200
     case 2:
         print("Zero-Day Vulnerability purchased.")
         simulateProgress()
         gameState.money -= 500
     case 3:
         print("Botnet Access purchased.")
         simulateProgress()
         gameState.money -= 300
     case 4:
         print("Encrypted VPN purchased.")
         simulateProgress()
         gameState.money -= 100
     case 5:
         print("Identity Spoofing Package purchased.")
         simulateProgress()
         gameState.money -= 150
    
     default:
         print("IDK Man")
     }
         
          }
     
    
    private func missionOne(){
        print("Connecting to Mission ListServ")
        simulateProgress()
        clearScreen()
        print("That's all i got for now")
        usleep(2500000)
        clearScreen()
    }
    private func missionTwo(){
        print("Connecting to Mission ListServ")
        simulateProgress()
        clearScreen()
        print("That's all i got for now")
        usleep(2500000)
        clearScreen()
    }
    private func missionThree(){
        print("Connecting to Mission ListServ")
        simulateProgress()
        clearScreen()
        print("That's all i got for now")
        usleep(2500000)
        clearScreen()
    }
    private func missionFour(){
        print("Connecting to Mission ListServ")
        simulateProgress()
        clearScreen()
        print("That's all i got for now")
        usleep(2500000)
        clearScreen()
    }
    private func missionFive(){
        print("Connecting to Mission ListServ")
        simulateProgress()
        clearScreen()
        print("That's all i got for now")
        usleep(2500000)
        clearScreen()
    }
    
    private func simulateProgress(duration: Int = 1) {
        let chars = ["|", "/", "-", "\\"]
        for i in 0..<(duration * 4) {
            print("\r\(chars[i % 4]) Working...", terminator: "")
            fflush(stdout)
            usleep(250000) // 0.25 seconds
        }
        print("\r✓ Complete!   ")
    }
    
    private func clearScreen() {
        print("\u{001B}[2J\u{001B}[H", terminator: "")
    }
    
    private func exitGame() {
        print("\nDisconnecting from the server...")
        print("Your final stats:")
        gameState.displayStats()
        print("Thanks for playing Hacker Simulator!")
        print("Remember: This is just a game. Use your skills ethically!")
        isRunning = false
    }
}

// MARK: - Main Entry Point
let game = HackerGame()
game.start()
