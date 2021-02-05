import Test.Hspec        (Spec, it, shouldBe)
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)

import Tleft (tleft)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} specs

specs :: Spec
specs = do
     it "Substrac two times" $
      tleft ["10:10", "09:02"] `shouldBe` Just (1, 8)

     it "Substrac two times lesser hour greater minute" $
      tleft ["10:10", "09:11"] `shouldBe` Just (0, 59)

     it "Substract times stamps using one digit hours" $
      tleft ["10:10", "9:02"] `shouldBe` Just (1, 8)

     it "Substract times stamps using one digit minut" $
      tleft ["10:1", "9:2"] `shouldBe` Nothing 

     it "Substrac same time" $
      tleft ["10:10", "10:10"] `shouldBe` Just (0, 0)

     it "First time bigger than the second" $
      tleft ["10:10", "11:10"] `shouldBe` Just (-1, 0)

     it "Substrac three times" $
      tleft ["10:10", "09:02", "01:00"] `shouldBe` Just (0, 8)

     it "Pass singleton list" $
      tleft ["10:10"] `shouldBe` Just (10, 10) 

     it "Pass words" $
      tleft ["he:llo"] `shouldBe` Nothing 