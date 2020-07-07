// list of endpoints:-

const BASEURL = 'https://project78.herokuapp.com/api';

// I) Authorization

// 1.)
const SIGNUP = BASEURL + "/signup"; //(post request to signup the user)
//  (body: {name:String, email:String, phoneno: Number, Uclass:String, password: String})

// 2.)
const LOGIN = BASEURL + "/signin"; // (post request to signin the user)
// (body: {email: String, password: String})

// II) Admin Only

// 1.)
const COMPETITIONS = BASEURL +
    "/add/newcompetition"; //(post request to add new competition in the database)
// (body:{name:String, description:String, important:String, campaignbrief:String ,urls:String, images:String})

// 2.)
const SHOWENTRIES = BASEURL +
    "/view/competition/submission/"; //+competitionId//(post request to fetch students entries by competition Id. Pass competitionId in the URL)
// (body:NIL);
// {Test competitionId => competition7:  5ef4e70150dd121a3c6dd3fe}
// 3.)
const SHOWALLUSERS =
    BASEURL + "/get/allusers"; //(post request to view all users in database)
//  (body:NIL)

//4.)
const DELETECOMP = BASEURL +
    "/deletethis/competition/"; //+competitionId (DELETE request to delete competition and their entries in database)
//  (body:NIL)

//5.)
const GETDELCOMP = BASEURL +
    "/get/recentely/deleted"; // (get request to view all recentely deleted competition)
//  (body:NIL)

// III) User Only

// 1.)
const ALLCOMPETITIONS = BASEURL +
    "/getall/competition"; //(get request to view all competition in database)
//  (body:NIL)

// 2.)
const SUBMITENTRY = BASEURL +
    "/save/competition/"; // (post request to save entry by user in database. Pass userId and competitionId in URL)
// (body: {message: String, imageurl:String, videourl:String})
// {Test userId =>  Lakshy:- 5ef49dd6388ac40024a44706 }
// {Test competitionId => Competition7:- 5ef4e70150dd121a3c6dd3fe}

// 3.)
const VIEWSUBMISSION = BASEURL +
    "/view/mysubmission/"; //+userId (post request to fetch user submission. Pass userId in the URL)
// (body:NIL)
// {Test userId => Ritik:- 5ef49cdd388ac40024a44704, Lakshy:- 5ef49dd6388ac40024a44706 }
