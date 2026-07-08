-----------------------------------
-- EXP to difficulty curve for /check
-- as well as Incredibly Easy Prey stuff
-----------------------------------
xi = xi or {}
xi.expDifficultyCurve = xi.expDifficultyCurve or {}

xi.expDifficultyCurve.loadExpDifficultyCurve = function()
    -- Above 1 exp and >= 56 but below Easy Prey check, /check will return IEP and the mob will grant exp.
    -- Set level to 255 to prevent IEP in general (no mobs will be level 255)
    local incrediblyEasyPreyLevel  = 56
    local incrediblyEasyPreyMinExp = 1

    -- exp value >= returns X difficulty
    -- [exp] = xi.mobDifficulty
    local expToDifficultyTable =
    {
        [400] = xi.mobDifficulty.INCREDIBLY_TOUGH,
        [350] = xi.mobDifficulty.VERY_TOUGH,
        [220] = xi.mobDifficulty.TOUGH,
        [200] = xi.mobDifficulty.EVEN_MATCH,
        [160] = xi.mobDifficulty.DECENT_CHALLENGE,
        [60]  = xi.mobDifficulty.EASY_PREY,
        -- Nothing below 60 so that is too weak
    }

    -- Load into C++
    LoadExpDifficultyCurves(expToDifficultyTable, incrediblyEasyPreyLevel, incrediblyEasyPreyMinExp)
end
