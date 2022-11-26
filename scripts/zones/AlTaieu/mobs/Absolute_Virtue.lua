-----------------------------------
-- Area: Al'Taieu
--  HNM: Absolute Virtue
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- setMod
    mob:setMod(xi.mod.REGEN, 500)

    local jailerOfLove = GetMobByID(ID.mob.JAILER_OF_LOVE)
    -- Special check for regen modification by JoL pets killed
    if jailerOfLove:getLocalVar("JoL_Qn_xzomit_Killed") == 9 then
        mob:addMod(xi.mod.REGEN, -130)
    end

    if jailerOfLove:getLocalVar("JoL_Qn_hpemde_Killed") == 9 then
        mob:addMod(xi.mod.REGEN, -130)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then -- Meteor
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280) -- AoE Meteor Animation
        spell:setMPCost(1)
    end
end

entity.onMagicHit = function(caster, target, spell)
    -- local regenMod = target:getMod(xi.mod.REGEN)
    local dayOfWeek = VanadielDayOfTheWeek()
    local spellElement = spell:getElement()

    if GetServerVariable("AV_Regen_Reduction") < 60 then
        -- Had to serverVar the regen instead of localVar because localVar reset on claim loss.
        if
            spellElement == xi.magic.dayElement[dayOfWeek] and
            (caster:isPC() or caster:isPet())
        then
            SetServerVariable("AV_Regen_Reduction", 1 + GetServerVariable("AV_Regen_Reduction"))
            target:addMod(xi.mod.REGEN, -2)
        end
    end

    return 1
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.VIRTUOUS_SAINT)
end

return entity
