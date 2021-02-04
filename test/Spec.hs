import Test.Hspec        (Spec, it, shouldBe)
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)

import Lib (tleft)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} specs

specs :: Spec
specs = do
     it "Substrac to two times" $
      tleft ["10:10", "09:02"] `shouldBe` Just (1, 8)

     it "Substrac to two times lesser hour greater minute" $
      tleft ["10:10", "09:11"] `shouldBe` Just (0, 59)

     it "Substrac same time" $
      tleft ["10:10", "10:10"] `shouldBe` Just (0, 0)

     it "Substrac three times" $
      tleft ["10:10", "09:02", "01:00"] `shouldBe` Just (0, 8)