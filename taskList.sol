pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract taskList {
    struct task
    {
        string name;
        uint32 timestamp;
        bool done;
    }
    mapping(uint8 => task) tasks;
    uint8 counter = 0;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function addTask(string name) public
    {
        tvm.accept();
        task newTask = task(name, now, false);
        tasks[counter] = newTask;
        ++counter;
    }

    function getNumOfTasks() public returns (uint8)
    {
        tvm.accept();
        uint8 returnVal = 0;
        for (uint8 i = 0; i < counter; ++i) 
        {
            if(!tasks[i].done && tasks[i].timestamp != 0) ++returnVal;            
        }
        return returnVal;
    }

    function getListOfTasks() public returns (mapping(uint8 => task))
    {
        tvm.accept();
        return tasks;
    }

    function getDescription(uint8 key) public returns (string)
    {
        tvm.accept();
        return tasks[key].name;
    }

    function deleteTask(uint8 key) public
    {
        tvm.accept();
        delete tasks[key];
    }

    function getTaskDone(uint8 key) public
    {
        tvm.accept();
        tasks[key].done = true;
    }
}
