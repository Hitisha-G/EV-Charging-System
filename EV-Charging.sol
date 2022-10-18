// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract EVChargingEcoSystem
{
    struct PCS_Owner {
        uint id_owner;
        string name_owner;
        uint age_owner;
        string gender_owner;
        uint phn_owner;
        //string email;
        bool status_owner;
        address payable pcs_owner;
    }
    //for pcs owner mapping simple
    mapping(uint => PCS_Owner) public owners;
    //mapping(address => PCS_Owner) owmners;
    uint public numOwner;

    struct PCS{
        uint id_pcs;
        string location;
        bool available;
        address owner_add;
        uint pre_amount;
        //assuming standard slot time 30 mins
        bool status_pcs  ;
        
    }
    //for PCS mapping simple
    mapping(uint => PCS) public pcss;
    uint public numPcs;

     //for pcs owner registration mapping 
    mapping(address=> bool) registered_owner;
    


    function register_owner(string memory _name,uint _age,uint _phone,string memory _gender)payable public returns(bool,string memory,uint,uint,string memory) //RegisterOnce 
    {
        require(registered_owner[msg.sender]!=true,"already registered");
        PCS_Owner storage newOwner= owners[numOwner];

        newOwner.pcs_owner=payable(msg.sender);
        newOwner.id_owner=numOwner;
        numOwner++;
        newOwner.gender_owner=_gender;
        newOwner.name_owner=_name;
        newOwner.age_owner=_age;
        newOwner.phn_owner=_phone;
        newOwner.status_owner=true;
        registered_owner[msg.sender] = true;
        return( registered_owner[msg.sender],newOwner.name_owner,newOwner.age_owner,newOwner.phn_owner,newOwner.gender_owner);

    }

     modifier RegisterOnce{
        require(registered_owner[msg.sender]!=true);
        _;
    }
   

    modifier OnlyOwner{
        require(registered_owner[msg.sender]==true);
        _;
    }
    mapping(address => string ) getOwner;
    //mapping(address => PCS_) getOwner;

    function register_pcs(uint _uid,string memory _location,uint _price) payable public returns(bool, string memory ,uint,bool) //OnlyOwner
    {
        require(registered_pcs[_uid]!=true," already registered");
        require(registered_owner[msg.sender]==true,"owner not registered");
        PCS storage newPCS= pcss[numPcs];
        newPCS.id_pcs=_uid;
        numPcs+=1;
        newPCS.available=true;
        newPCS.owner_add=msg.sender;
        newPCS.location=_location;
        newPCS.pre_amount=_price;
        newPCS.status_pcs=true;
        registered_pcs[_uid]=true;
        return( registered_pcs[_uid],getOwner[msg.sender],newPCS.pre_amount,newPCS.status_pcs);

    }
    //for pcs owner registration mapping 
    mapping(uint=> bool) registered_pcs;

    struct User
    {
        uint user_id;
        string name_user;
        uint age_user;
        address payable user;
        string gender_user;
        bool status_user;
        uint phone_user;
        // array for registered
       // registered_user[msg.sender] = true;

    }
    //for User mapping simple
     mapping(uint => User) public users;
    uint public numUser;

    //for user registration
    mapping(address=>bool) public registered_user;
    mapping(address=>User) public registered_userforSTOP;

    function register_user(string memory _name,uint _age,uint _phone,string memory _gender)payable public returns(bool,string memory,uint,uint,string memory)  //RegisterOnce 
    {
        require(registered_user[msg.sender]!=true,"already registered");
        User storage newUser= users[numUser];

        newUser.user=payable(msg.sender);
        newUser.user_id=numUser;
        numUser++;
        newUser.gender_user=_gender;
        newUser.name_user=_name;
        newUser.age_user=_age;
        newUser.phone_user=_phone;
        newUser.status_user=true;
        registered_user[msg.sender] = true;
        return(registered_user[msg.sender],newUser.name_user,newUser.age_user,newUser.phone_user,newUser.gender_user);

    }

     //uint startTime;


//    function START(uint pcs_uid,uint _amount,address payable code) payable public returns(bool) //only registered user 
  //  {
        //require(amount)
        
        ///require(user.pcs_uid);
//        require(registered_user[msg.sender]!=true,'');

  //      require(pcss[pcs_uid].available==true,"station not available");
  //      code.transfer(_amount);
  //      return(true);


        
      // return()

        //for time
     //   startTime = now;
     // deadline=block.timestamp+_deadline; 
      //  registered_user[msg.sender] = true;
        //  update collected

    }

    uint collected;
    mapping (address => uint)  user_payed;


    function refund(uint _ramount) public payable 
    {
        address payable ruser= payable(msg.sender);
        uint difference =_ramount;
       /// diff_time=
        ruser.transfer(user_payed[msg.sender]);
        collected-=user_payed[msg.sender];
        user_payed[msg.sender]=0;
        //registered_userforSTOP[msg.sender].



    }

    //function STOP()

}
