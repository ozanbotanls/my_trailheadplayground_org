public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer numberOfArray) {
        List<String> stringList = new List<String>{ 'test', 'test2', 'test3' };  
        List<String> toBeReturned = new List<String>();
        for (Integer i = 0; i < numberOfArray; i++){
            toBeReturned.add('Test ' + i);
        }
        return toBeReturned;
    }

}