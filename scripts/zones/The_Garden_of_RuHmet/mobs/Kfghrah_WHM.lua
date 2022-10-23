-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Kf'ghrah WHM
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic") -- no spells are currently set due to lack of info
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Set core Skin and mob elemental bonus
    mob:setAnimationSub(0)
    mob:setLocalVar("roamTime", os.time())
    mob:setModelId(1167) -- light

    -- Todo: confirm this is legit and move to mob_reistances table if so
    mob:addMod(xi.mod.LIGHT_MEVA, 100)
    mob:addMod(xi.mod.DARK_MEVA, -100)
end

entity.onMobRoam = function(mob)
    local roamTime = mob:getLocalVar("roamTime")
    local roamForm
    if (os.time() - roamTime > 60) then
        roamForm = math.random(1, 3) -- forms 2 and 3 are spider and bird; can change forms at will
        if (roamForm == 1) then
            roamForm = 0 -- We don't want form 1 as that's humanoid - make it 0 for ball
        end
        mob:setAnimationSub(roamForm)
        mob:setLocalVar("roamTime", os.time())
    end
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local battleForm

    if (mob:getBattleTime() - changeTime > 60) then
        battleForm = math.random(1, 3) -- same deal as above
        if (battleForm == 1) then
            battleForm = 0
        end
        mob:setAnimationSub(battleForm)
        mob:setLocalVar("changeTime", mob:getBattleTime())
        if mob:setAnimationSub() == 0 then
            mob:SetMagicCastingEnabled(true) -- will only cast magic in ball form
        else
            mob:SetMagicCastingEnabled(false)
        end
    end
end

entity.onMagicCastingCheck = function(mob, target, spell)
    local rnd = math.random()
    if rnd < 0.2 then
        return xi.magic.spell.BANISHGA_III
    elseif rnd < 0.6 then
        return xi.magic.spell.BANISH_IV
    else
        return xi.magic.spell.FLASH
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
