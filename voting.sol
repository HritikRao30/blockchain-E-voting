pragma solidity >= 0.7.0 <0.8.0
contract ballot{
    struct vote{
        address voterAddress;
        bool choice;
    }
    struct voter{
        string voterName;
        bool voted;
    }
    uint private countResult = 0;
    uint public finalResult = 0;
    uint public totalVoter = 0;
    uint public totalVote = 0;

    address public ballotOfficialAddress;
    string public ballotOfficialName;
    string public proposal;

    mapping(uint => vote) private votes;
    mapping(address => voter) public voterRegister;

    enum state{Created,Voting,Ended}
    State public state;

    //modifier
    modifier condition(bool _condition){
        require(_condition);
        _;
    }
    modifier onlyOfficial(bool _condition){
        require(msg.sender == ballotOfficialAddress);
        _;
    }
    modifier inState(State _state){
        require(state == _state);
        _;
    }
    //function
    constructor(string memory _ballotOfficialName,
    string memory _proposal) 
    public{
        ballotOfficialAddress = msg.sender;
        ballotOfficialName = _ballotOfficialName;
        proposal = _proposal;
        state = State.Created;
    }
    function addVoter(
        address _voterAddress,
        string memory _voterName
    )public
        instate(State.Created)
        onlyOfficial
    {
        voter memory v;
        v.voterName = voterName;
        v.voted = false;
        voterRegister[_voterAddress] = v;
        totalVoter++;
    }
    function startVote()
    public instate(State.Created)
    onlyOfficial
    {
        state = State.Voting;
    }
    function doVote(bool _choice)
    public
    inState(State.Voting)
    returns (bool voted){
        bool isFound = false;
        if(byte(voterRegister[msg.sender].voterName).length != 0
        && voterRegister[msg.sender].voted == false){
            voterRegister[msg.sender].voted = true;
            vote memory v;
            v.choice = _choice;
            v.voterAddress = msg.sender;
            if(_choice){
                countResult++;
            }
            votes[totalVote] = v;
            totalVote++;
            bool isFound = true;
        }
        return isFound;
    }
    function endVote()
    public 
    instate(Ended)
    onlyOfficial{
        state = State.Ended;
        finalResult = countResult;
    }
}