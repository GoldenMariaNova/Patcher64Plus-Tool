function PatchOptions() {
    
    # GRAPHICS #

    if (IsChecked $Redux.Graphics.FixBurnSmoke) { ApplyPatch -Patch "Compressed\Optional\fix_burn_smoke.ppf" }



    # GAMEPLAY #

    if (IsChecked $Redux.Gameplay.FPS)       { ApplyPatch -Patch "Compressed\Optional\fps.ppf" }
    if (IsChecked $Redux.Gameplay.FreeCam)   { ApplyPatch -Patch "Compressed\Optional\cam.ppf" }

}



#==============================================================================================================================================================================================
function ByteOptions() {
    
    # HERO MODE

    if     (IsText -Elem $Redux.Hero.Damage -Compare "2x Damage")   { ChangeBytes -Offset "F207" -Values "80" }
    elseif (IsText -Elem $Redux.Hero.Damage -Compare "3x Damage")   { ChangeBytes -Offset "F207" -Values "40" }



    # GRAPHICS #

    if (IsChecked $Redux.Graphics.WideScreen) {
        ChangeBytes -Offset "3855E" -Values "4740"
        ChangeBytes -Offset "35456" -Values "46C0"
    }

    if (IsChecked $Redux.Graphics.BlackBars) {
        ChangeBytes -Offset "23A7"  -Values "BC00" -Interval 12
        ChangeBytes -Offset "248E"  -Values "00"
        ChangeBytes -Offset "2966"  -Values "0000" -Interval 48
        ChangeBytes -Offset "3646A" -Values "00"; ChangeBytes -Offset "364AA" -Values "00"; ChangeBytes -Offset "364F6" -Values "00"; ChangeBytes -Offset "36582" -Values "00"
        ChangeBytes -Offset "3799F" -Values "BC00" -Interval 12
    }

    if (IsChecked $Redux.Graphics.ExtendedDraw) {
        ChangeBytes -Offset "1007F0" -Values "00000000";     ChangeBytes -Offset "1008B8" -Values "00000000"; ChangeBytes -Offset "1008D0" -Values "00000000" # Solid objects
        ChangeBytes -Offset "36D2C"  -Values "95E90022"
        ChangeBytes -Offset "66FE6"  -Values "469C44815000"; ChangeBytes -Offset "66F56"  -Values "469C" # Coin formations
    }

    if (IsChecked $Redux.Graphics.ForceHiresModel)         { ChangeBytes -Offset "32184" -Values "10 00" }

    

    # GAMEPLAY #

    if (IsChecked $Redux.Gameplay.NoGameOver) {
        ChangeBytes -Offset "5B10"  -Values "24080001"
        ChangeBytes -Offset "5B98"  -Values "240E0001"
        ChangeBytes -Offset "98118" -Values "000000000000000000000000000000000000000000000000000000000000000000000000"
        ChangeBytes -Offset "9EDB0" -Values "0000"
        ChangeBytes -Offset "9813C" -Values "3C088034"
    }

    if (IsChecked $Redux.Gameplay.LagFix)                       { ChangeBytes -Offset "F0022" -Values "0D"       }
    if (IsChecked $Redux.Gameplay.ExitLevelAnytime)             { ChangeBytes -Offset "97B74" -Values "00000000" }
    if (IsChecked $Redux.Gameplay.NoEndlessStairs)              { ChangeBytes -Offset "53AC"  -Values "1000"     }
    if (IsChecked $Redux.Gameplay.NoFallDamage)                 { ChangeBytes -Offset "25044" -Values "10"; ChangeBytes -Offset "252F4" -Values "10000018"; ChangeBytes -Offset "25368" -Values "10" }
    if (IsChecked $Redux.Gameplay.CanNotLoseCap)                { ChangeBytes -Offset "7945"  -Values "00"; ChangeBytes -Offset "7A89" -Values "00" }
    if (IsChecked $Redux.Gameplay.InvincibleJump)               { ChangeBytes -Offset "26828" -Values "2400"     }
    if (IsDefault $Redux.Gameplay.Lives -Not)                   { ChangeBytes -Offset "1001B" -Values $Redux.Gameplay.Lives.Text -IsDec }



    # INTERFACE #
    if (IsChecked $Redux.UI.HideHUD) {
        ChangeBytes -Offset "9EB69" -Values "11 80 34 82 31 AF A1 24 12 00 20 16 51 00 68 00 00 00 00"
        PatchBytes  -Offset "9EDA0" -Patch "Hide HUD.bin"
    }



    # SKIP #

    if (IsChecked $Redux.Skip.MarioScreen)                 { ChangeBytes -Offset "269F18" -Values "0110001400269EA00026A3A01400020C"         }
    if (IsChecked $Redux.Skip.TitleScreen)                 { ChangeBytes -Offset "269ECC" -Values "340400000110001400269EA00026A3A014000078" }
    if (IsChecked $Redux.Skip.GameOverScreen)              { ChangeBytes -Offset "269FA4" -Values "0110001400269EA00026A3A01400020C"         }
    if (IsChecked $Redux.Skip.PeachIntro)                  { ChangeBytes -Offset "6BD4"   -Values "2400" }

    if (IsChecked $Redux.Skip.StarMessages)                { ChangeBytes -Offset "123F8"  -Values "1000"     }
    if (IsChecked $Redux.Skip.BoosDialogue)                { ChangeBytes -Offset "7F774"  -Values "A7200074" }
    if (IsChecked $Redux.Skip.Lakitu)                      { ChangeBytes -Offset "6D90"   -Values "24100000" }
    if (IsChecked $Redux.Skip.StageIntro)                  { ChangeBytes -Offset "4924"   -Values "1000"; ChangeBytes -Offset "4B7C" -Values "2400" }

}



#==============================================================================================================================================================================================
function CreateOptions() {
    
    CreateOptionsPanel -Tabs @("Graphics", "Gameplay", "Skip")

}



#==============================================================================================================================================================================================
function CreateTabGraphics() {

    # GRAPHICS #

    CreateReduxGroup    -Tag  "Graphics"           -Text "Graphics"
    CreateReduxCheckBox -Name "Widescreen"   -Safe -Text "16:9 Widescreen"         -Info "Native 16:9 Widescreen Display support" -Warning "Requires Dolphin's or GlideN64's internal Widescreen Hack" -Credits "Theboy181 (RAM) & Admentus (ROM)"
    CreateReduxCheckBox -Name "BlackBars"          -Text "No Black Bars"           -Info "Removes the black bars shown on the top and bottom of the screen"                                            -Credits "Theboy181 (RAM) & Admentus (ROM)"
    CreateReduxCheckBox -Name "ExtendedDraw" -Safe -Text "Extended Draw Distance"  -Info "Increases the game's draw distance for solid objects with collision`nIncludes coin formations as well"       -Credits "Theboy181 (RAM) & Admentus (ROM)"
    CreateReduxCheckBox -Name "ForceHiresModel"    -Text "Force Hires Mario Model" -Info "Always use Mario's High Resolution Model when Mario is too far away"                                         -Credits "Theboy181 (RAM) & Admentus (ROM)"
    CreateReduxCheckBox -Name "FixBurnSmoke"       -Text "Fix Burn Smoke"          -Info "Fix the burn smoke texture"                                                                                  -Credits "Admentus"



    # INTERFACE #

    CreateReduxGroup    -Tag  "UI"-Text "Interface"
    CreateReduxCheckBox -Name "HideHUD" -Text "Hide HUD" -Info "Hide the HUD by default and press L to make it appear`nEnable the 'Remap L Button' VC option when patching a WAD" -Credits "Ported from SM64 ROM Manager"

}



#==============================================================================================================================================================================================
function CreateTabGameplay() {
    
    # HERO MODE #

    CreateReduxGroup    -Tag  "Hero"   -Text "Hero Mode"
    CreateReduxComboBox -Name "Damage" -Items @("1x Damage", "2x Damage", "3x Damage") -Text "Damage" -Info "Set the amount of damage you receive"



    # GAMEPLAY #

    CreateReduxGroup    -Tag  "Gameplay"         -Text "Gameplay"
    CreateReduxCheckBox -Name "FPS"        -Safe -Text "60 FPS"               -Info "Increases the FPS from 30 to 60`nWitness Super Mario 64 in glorious 60 FPS"                                                         -Credits "Kaze Emanuar"
    CreateReduxCheckBox -Name "FreeCam"          -Text "Analog Camera"        -Info "Enable full 360 degrees sideways analog camera`nEnable a second emulated controller and bind the Left / Right for the Analog stick" -Credits "Kaze Emanuar" -Link $Redux.Gameplay.FPS
    CreateReduxCheckBox -Name "LagFix"           -Text "Lag Fix"              -Info "Smoothens gameplay by reducing lag"                                                                                                 -Credits "Admentus"
    CreateReduxCheckBox -Name "ExitLevelAnytime" -Text "Exit Level Anytime"   -Info "Exit the level at any time without the need for standing still"                                                                     -Credits "Ported from SM64 Tweaker"
    CreateReduxCheckBox -Name "NoEndlessStairs"  -Text "No Endless Stairs"    -Info "The endless stairs to reach the the Bowser in the Sky stage is disabled"                                                            -Credits "Ported from SM64 Tweaker"
    CreateReduxCheckBox -Name "NoFallDamage"     -Text "No Fall Damage"       -Info "Mario will not lose any health when falling from height too far"                                                                    -Credits "Ported from SM64 Tweaker"
    CreateReduxCheckBox -Name "CanNotLoseCap"    -Text "Can Not Lose Cap"     -Info "Mario will not lose his cap anymore"                                                                                                -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "InvincibleJump"   -Text "Have Invincible Jump" -Info "Mario can use the Invincible Triple Jump without having to talk to Yoshi after obtaining all 120 Power Stars"                       -Credits "Admentus"

    CreateReduxGroup    -Tag  "Gameplay"         -Text "Lives"
    CreateReduxTextBox  -Name "Lives"            -Text "Lives"       -Value 4 -Info "Set the amount of lives Mario starts with when opening the save file"                                                               -Credits "Ported from SM64 Tweaker"
    CreateReduxCheckBox -Name "NoGameOver"       -Text "No Game Over"         -Info "The game won't end if Mario's lives reaches below 0"                                                                                -Credits "Kaze Emanuar"

}



#==============================================================================================================================================================================================
function CreateTabSkip() {

    # SKIP #

    CreateReduxGroup    -Tag  "Skip"                -Text "Skip Intro"
    CreateReduxCheckBox -Name "TitleScreen" -Base 1 -Text "Skip Title Screen"     -Info "Skip the title screen shown when booting the game`nThis option only works when modifying the vanilla Super Mario 64 game"                           -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "MarioScreen" -Base 1 -Text "Skip Mario Screen"     -Info "Skip the screen which displays Mario's face and the title in the background`nThis option only works when modifying the vanilla Super Mario 64 game" -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "GameOverScreen"      -Text "Skip Game-Over Screen" -Info "Skip the game-over screen shown when losing all lives"                                                                                              -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "PeachIntro"          -Text "Skip Peach Intro"      -Info "Skip the introduction cutscene sequence when starting a new save file"                                                                              -Credits "Ported from SM64 ROM Manager"

    CreateReduxGroup    -Tag  "Skip"                -Text "Skip In-Game"
    CreateReduxCheckBox -Name "StarMessages"        -Text "Skip Star Messages"    -Info "Skip the messages displayed after collecting specific numbers of stars"                                                                             -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "BoosDialogue"        -Text "Remove Boos Dialogue"  -Info "Removes the dialogue for defeating Boos or when the Big Boo appears"                                                                                -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "Lakitu"              -Text "Skip Lakitu"           -Info "Skip the lakitu intro before entering the castle for the first time"                                                                                -Credits "Ported from SM64 ROM Manager"
    CreateReduxCheckBox -Name "StageIntro"          -Text "Skip Stage Intro"      -Info "Skip any messages that show up when entering a stage"                                                                                               -Credits "Ported from SM64 ROM Manager"

}