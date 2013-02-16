package tests 
{
	import flash.display.Sprite;
	import roekensk.dao.UserDao;
	import roekensk.dao.UserDaoEvent;
	import roekensk.flex.entities.User;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class DaoTest extends Sprite
	{
		private var userDao:UserDao;
		public function DaoTest() 
		{
			userDao = new UserDao();
			
			userDao.addEventListener(UserDaoEvent.LOGIN_SUCCESS, onUserDaoComplete);
			userDao.addEventListener(UserDaoEvent.LOGIN_FAILED, onUserDaoComplete);
			userDao.addEventListener(UserDaoEvent.REGISTER_FAILED, onUserDaoComplete);
			userDao.addEventListener(UserDaoEvent.REGISTER_SUCCESS, onUserDaoComplete);
			
			
			var user:User = new User("daoTestUser2");
			user.password = "test";
			user.email = "test@test.com";
			//userDao.registerUser(user);
			userDao.login("daoTestUser2", "test");
			
		}
		
		private function onUserDaoComplete(e:UserDaoEvent):void {
			trace(e.toString());
			if (e.type == UserDaoEvent.LOGIN_SUCCESS) {
				var user:User = e.target.user as User;
				trace(user.username+" logged in!");
			} else if (e.type == UserDaoEvent.REGISTER_SUCCESS) {
				trace("user registered");
				
			} else if (e.type == UserDaoEvent.LOGIN_FAILED) {
				trace("login failed");
			} else if(e.type == UserDaoEvent.REGISTER_FAILED) {
				trace("register failed");
			}
		}
		
	}
	
}