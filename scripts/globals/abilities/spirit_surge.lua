-----------------------------------
-- Ability: Spirit Surge
-- Adds your wyvern's strength to your own.
-- Obtained: Dragoon Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    -- The wyvern must be present in order to use Spirit Surge
    if (target:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Spirit Surge increases dragoon's MAX HP increases by 25% of wyvern MaxHP
    -- bg wiki says 25% ffxiclopedia says 15%, going with 25 for now
    local mhp_boost = target:getPet():getMaxHP()*0.25
    -- Dragoon gets all of wyverns TP when using Spirit Surge
    local pet = player:getPet()
    local petTP = pet:getTP()
    target:addTP(petTP) --add pet TP to dragoon
    pet:delTP(petTP) -- remove TP from pet
    -- Spirit Surge increases dragoon's Strength
    local strBoost = 0
    if (target:getMainJob() == tpz.job.DRG) then
        strBoost = (1 + target:getMainLvl()/5) -- Use Mainjob Lvl
    else
        strBoost = (1 + target:getSubLvl()/5)  -- Use Subjob Lvl
    end

    local duration = 60

    target:despawnPet()
    -- All Jump recast times are reset
    target:resetRecast(tpz.recast.ABILITY, 158) -- Jump
    target:resetRecast(tpz.recast.ABILITY, 159) -- High Jump
    target:resetRecast(tpz.recast.ABILITY, 160) -- Super Jump

    target:addStatusEffect(tpz.effect.SPIRIT_SURGE, mhp_boost, 0, duration, 0, strBoost)
end
