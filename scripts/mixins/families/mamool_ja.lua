-----------------------------------
-- Mamool Ja Family
-----------------------------------
local mixin = function(mamoolJaMob)
    mamoolJaMob:addListener('WEAPONSKILL_STATE_EXIT', 'MAMOOL_JA_AMBUSH_FINISH', function(mob, skillID)
        -- Remove weapon after using Javelin Throw, Axe Throw, or Stave Toss
        if skillID == 1735 or skillID == 1736 or skillID == 1925 or skillID == 2361 then
            mob:setAnimationSub(2)
        end
    end)
end

return mixin
