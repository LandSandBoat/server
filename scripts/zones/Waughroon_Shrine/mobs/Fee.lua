-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Fe'e
-- BCNM: Up In Arms
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MULTI_HIT, 6)
    mob:setMod(xi.mod.BINDRES, 20)
    mob:setMod(xi.mod.BLINDRES, 20)
    mob:setMod(xi.mod.SLEEPRES, 20)
    mob:setMod(xi.mod.LULLABYRES, 20)
    mob:setMod(xi.mod.GRAVITYRES, 20)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("tentacles", 6)
    mob:SetMobSkillAttack(0)
end

-- Remove a tentacle from Fe'e.  This happens six times during the fight, with final at about 33% HP.
-- Each removal slows attack speed in exchange for TP regain and damage.
-- When all tentacles are removed, its normal melee attack is replaced by a special Ink Jet attack that
-- ignores shadows and has knockback.

local function removeTentacle(mob, tentacles)
    if tentacles > 0 then
        mob:setMobMod(xi.mobMod.MULTI_HIT, tentacles)
        mob:messageText(mob, ID.text.ONE_TENTACLE_WOUNDED, false)
    else
        mob:messageText(mob, ID.text.ALL_TENTACLES_WOUNDED, false)
        mob:SetMobSkillAttack(704) -- replace melee attack with special Ink Jet attack
    end
    mob:addMod(xi.mod.ATT, 50)
    mob:addMod(xi.mod.REGAIN, 50)
    mob:addMod(xi.mod.BINDRES, 10)
    mob:addMod(xi.mod.BLINDRES, 10)
    mob:addMod(xi.mod.SLEEPRES, 10)
    mob:addMod(xi.mod.LULLABYRES, 10)
    mob:addMod(xi.mod.GRAVITYRES, 10)
end

entity.onMobFight = function(mob, target)
    local tentacles = mob:getLocalVar("tentacles")

    if tentacles > 0 then
        local hpp = mob:getHPP()

        while hpp < (11 * tentacles + 22) and tentacles > 0 do
            tentacles = tentacles - 1
            removeTentacle(mob, tentacles)
        end

        mob:setLocalVar("tentacles", tentacles)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
