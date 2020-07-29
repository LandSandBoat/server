-----------------------------------
-- Area: Apollyon NW
--  Mob: Kaiser Behemoth
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 60)
end

function onSpellPrecast(mob, spell)
    if (spell:getID() == 218) then
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16932864+111):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+111):setStatus(tpz.status.NORMAL)
end
