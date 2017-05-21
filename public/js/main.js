setTimeout(function(){

var signUpForm = document.getElementsByClassName("sign-up-container")[0];
	signUpForm.classList.add ("fade")
	signUpForm.style.display = 'block';

var modal = document.getElementById("modal");
	modal.classList.add ("fade");
	modal.style.display = 'block';

}, 500);
