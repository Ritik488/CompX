
// list of endpoints:-

const BASEURL= 'https://project78.herokuapp.com/api';

// I) Authorization

// 1.) 
const SIGNUP = BASEURL+  "/signup"; //(post request to signup the user) 
	    //  (body: {name:String, email:String, phoneno: Number, Uclass:String, password: String})

// 2.) 
const LOGIN = BASEURL + "/signin"; // (post request to signin the user)
	    // (body: {email: String, password: String})

// II) Admin Only

// 1.) 
const COMPETITIONS= BASEURL +"/add/newcompetition"; //(post request to add new competition in the database)
		          // (body:{name:String, description:String, important:String, campaignbrief:String ,urls:String, images:String})

// III) User Only

// 1.) 
const ALLCOMPETITIONS= BASEURL + "/getall/competition"; //(get request to view all competition in database)
		      //  (body:NIL)