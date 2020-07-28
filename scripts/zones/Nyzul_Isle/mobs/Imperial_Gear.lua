-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Imperial Gear
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    local instance = mob:getInstance()
    local progress = instance:getProgress()

    if (progress >= 24) then
        local mobs = instance:getMobs()

        for i, v in pairs(mobs) do
            if (v:getID() == ID.mob[58].AMNAF_BLU) then
                local pos = v:getPos()

                if (mob:getID() == ID.mob[58].IMPERIAL_GEAR1) then
                    mob:setPos(pos.x+2, pos.y, pos.z, pos.rot)
                elseif (mob:getID() == ID.mob[58].IMPERIAL_GEAR2) then
                    mob:setPos(pos.x, pos.y, pos.z+2, pos.rot)
                elseif (mob:getID() == ID.mob[58].IMPERIAL_GEAR3) then
                    mob:setPos(pos.x-2, pos.y, pos.z, pos.rot)
                elseif (mob:getID() == ID.mob[58].IMPERIAL_GEAR4) then
                    mob:setPos(pos.x, pos.y, pos.z-2, pos.rot)
                end
            end
        end
    end
end

function onMobEngaged(mob, target)
    local naja = mob:getInstance():getEntity(bit.band(ID.mob[58].NAJA, 0xFFF))
    naja:setLocalVar("ready", 1)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
