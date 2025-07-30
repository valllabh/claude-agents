// Test Project - Main Entry Point
console.log('Welcome to the Claude Code Agents Test Project!');

class TestApp {
    constructor() {
        this.name = 'Claude Agents Test';
        this.version = '1.0.0';
    }

    start() {
        console.log(`Starting ${this.name} v${this.version}`);
        console.log('This project is used to test Claude Code agent installation and functionality.');
        
        // Simulate some work
        this.processData();
        this.generateReport();
    }

    processData() {
        console.log('Processing sample data...');
        const data = [1, 2, 3, 4, 5];
        const result = data.map(x => x * 2);
        console.log('Processed data:', result);
    }

    generateReport() {
        console.log('Generating test report...');
        const report = {
            timestamp: new Date().toISOString(),
            status: 'success',
            message: 'Test project is working correctly'
        };
        console.log('Report:', JSON.stringify(report, null, 2));
    }
}

const app = new TestApp();
app.start();