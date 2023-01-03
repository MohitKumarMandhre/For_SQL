CREATE PROCEDURE `isPrime` ( IN num integer)
BEGIN
	set x = 2;
    set pr = 1; 
    while x < num/2 +1
	do	
		if ( num mod x = 0) 
        then
			set pr = 0;
        end if;
        set x = x+1;
    end while;
    if ( pr = 0)
    then 
		select concat(x, " not pr");
	else
		select concat(x, " is prriiimmmmeeeee");
    end if;
SELECT str;
END
