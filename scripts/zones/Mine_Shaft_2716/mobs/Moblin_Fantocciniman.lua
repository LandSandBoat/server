-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Moblin Fantocciniman
-- ENM: Pulling the Strings
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:SetAutoAttackEnabled(false)
    mob:setSpeed(60)
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 375)

    -- Different message if engaging for the second time
    if mob:getLocalVar("control") == 0 then
        mob:showText(mob, ID.text.TIME_FOR_GOODEBYONGO)
    else
        mob:showText(mob, ID.text.HERE_TO_STAY)
    end
end

entity.onMobFight = function(mob, target)
    local fantoccini = GetMobByID(ID.mob.FANTOCCINI[mob:getBattlefield():getArea()])
    local fPos = fantoccini:getPos()
    local mPos = mob:getPos()

    if mob:getHP() < mob:getMaxHP() and mob:getLocalVar("control") == 0 then
        mob:showText(mob, ID.text.YOU_MAKE_ME_MAD)
        mob:addMobMod(xi.mobMod.SKILL_LIST, 0) -- Stops rolling dice after being attacked
        mob:SetAutoAttackEnabled(true)
        mob:setLocalVar("control", 1)
        mob:setBehaviour(0)

    -- Moblin stays within 8 yalms of the Fantoccini
    else
        if mob:checkDistance(fantoccini) > 8 then
            mob:pathTo(fPos.x, fPos.y, fPos.z, xi.path.flag.SCRIPT)
        else
            mob:pathTo(mPos.x, mPos.y, mPos.z, xi.path.flag.SCRIPT)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(target, mob)
    mob:showText(mob, ID.text.ROLY_POLY)
end

entity.onMobDeath = function(mob)
    mob:showText(mob, ID.text.NOT_HOW)

    for i= 0, 4 do
        local npc = GetMobByID(ID.mob.FANTOCCINI[mob:getBattlefield():getArea()] + i)
        if npc:isSpawned() then
            npc:addStatusEffect(xi.effect.TERROR, 0, 0, 900)
        end
    end
end

return entity
