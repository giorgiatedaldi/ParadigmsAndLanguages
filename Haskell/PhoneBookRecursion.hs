import Data.Maybe
import Text.Read

-- Implement a lookup f. for PhoneBook
-- getPhoneNumber :: Name -> PhoneBook -> PhoneNumber
-- Pattern
-- x:xs
-- Result if name not found:
-- ""
-- Use (tail) recursion
type Name = String
type PhoneNumber = String
type PhoneBook = [(Name, PhoneNumber)]

getPhoneNumber :: Name -> PhoneBook -> PhoneNumber
getPhoneNumber name [] = ""
getPhoneNumber name (x:xs)
 |name == fst x = snd x
 |otherwise = getPhoneNumber name xs


-- Implement a lookup f. for PhoneBook
-- getPhoneNumber :: Name -> PhoneBook -> PhoneNumber
-- Pattern
-- ((k,v):xs)
-- Result if name not found:
-- error "No phone number for " ++ name
-- Use (tail) recursion

getPhoneNumberError :: Name -> PhoneBook -> PhoneNumber
getPhoneNumberError name [] = error "No phone number for " ++ name
getPhoneNumberError name (x:xs)
 |name == fst x = snd x
 |otherwise = getPhoneNumberError name xs

--  Implement a f. for PhoneBook
-- Change signature to return Maybe PhoneNumber
-- getPhoneNumber :: Name -> PhoneBook -> Maybe PhoneNumber
-- Result if name not found:
-- Nothing
-- Use (tail) recursion

getPhoneNumberMaybe :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumberMaybe name [] = Nothing
getPhoneNumberMaybe name (x:xs)
 |name == fst x = Just (snd x )
 |otherwise = getPhoneNumberMaybe name xs


-- Implement a lookup f. for PhoneBook
-- getPhoneNumber :: Name -> PhoneBook -> Maybe PhoneNumber
-- Pattern
-- ((k,v):xs)
-- Result if name not found:
-- Nothing

getPhoneNumberFold :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumberFold name xs = foldl (\ acc (k,v) -> if k == name then Just v else acc) Nothing xs