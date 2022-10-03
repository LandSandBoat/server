-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Moblin Fantocciniman
-- ENM: Pulling the Strings
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local rolls =
{
    1414, -- Recover MP (player)
    1415, -- Recover HP (player)
    1416, -- Recover MP (player)
    1417, -- Attack Boost (player)
    1418, -- Defense Boost (player)
    1419, -- TP Boost (player)
    1420, -- Ability or Spell (automaton)
    1421, -- Give and use TP (automaton)
    1422, -- Attack Boost (automaton)
    1424, -- Defense Boost (automaton)
    1427, -- 2HR use (automaton)
    1457, -- Job ability Reset (player)
}

entity.onMobSpawn = function(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:SetAutoAttackEnabled(false)
    mob:setSpeed(60)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() >= 1400 then
        mob:showText(mob, ID.text.ROLY_POLY)
        mob:queue(3000, function(mobArg)
            mobArg:useMobAbility(math.random(1343,1345))
            mob:setLocalVar("tpControl", 0)
        end)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 300)

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

    -- Shares hate with Fantoccini
    mob:updateEnmity(fantoccini:getTarget())

    -- Attack player if any HP has been lost
    if mob:getHP() < mob:getMaxHP() and mob:getLocalVar("control") == 0 then
        mob:showText(mob, ID.text.YOU_MAKE_ME_MAD)
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

    -- *** TODO: Fix the requirement of this to roll on Fantoccini ***
    -- ** Moblin won't roll on Fantoccini unless explicitly told to **
    if mob:getTP() == 3000 and mob:getLocalVar("control") == 0 and mob:getLocalVar("tpControl") == 0 then
        mob:setLocalVar("tpControl", 1)
        mob:useMobAbility(rolls[math.random(1,12)])
    end
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
