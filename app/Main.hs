module Main where

import Control.Monad
import Options.Applicative.Simple
import System.Process.Typed

main :: IO ()
main = do
  ((email, domains, duration), ()) <-
    simpleOptions
      "0.0.0"
      "certbot-loop"
      "A simple standalone looping certbot wrapper"
      ((,,) <$>
       strOption (long "email" <> help "Same meaning as certbot's --email.") <*>
       strOption (long "domains" <> help "Same syntax as certbot's --domains.") <*>
       strOption
         (long "duration" <>
          help "Specified in sleep(1) notation (1s, 2d, etc.)"))
      empty
  putStrLn "Running certonly ..."
  runProcess_
    (proc
       "certbot"
       [ "certonly"
       , "-n"
       , "--standalone"
       , "--agree-tos"
       , "--email"
       , email
       , "--domains"
       , domains
       ])
  putStrLn ("Running renew loop every " ++ duration)
  forever
    (do runProcess_ (proc "sleep" [duration])
        runProcess_ (proc "certbot" ["renew"]))
