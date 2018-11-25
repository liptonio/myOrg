public class AssignCustomProfiles {
  
    public static void assignProfileToUser(Set<User> userIds) {
        List<User> updatedUserlst = new List<User>();
        profile p = [SELECT ID FROM profile WHERE name='Force.com - Free User'];
            if(userIds.size() > 0 && userIds != null){
                for(User u : userIds)
                {  
                    u.profileID = p.id;
                    updatedUserlst.add(u);
                } 
            }
       update updatedUserlst;
   }
}