-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB: Namorodo
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:timer(30000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        GetMobByID(ID.mob.NAMORODO):isDead() and
        GetMobByID(ID.mob.NAMORODO + 1):isDead() and
        GetMobByID(ID.mob.NAMORODO + 2):isDead() and
        optParams.isKiller
    then
        for _, v in ipairs(player:getParty()) do
            if
                player:getZoneID() == v:getZoneID() and
                player:checkDistance(v) <= 50
            then
                local fellow = v:getFellow()
                if fellow ~= nil then
                    v:showText(fellow, ID.text.SEEMS_TO_BE_THE_END + xi.fellow_utils.checkPersonality(fellow))
                    v:setCharVar("[Quest]Looking_Glass", 3)
                    v:timer(45000, function(playerArg)
                        playerArg:despawnFellow()
                    end) -- 45 sec to talk to fellow
                end
            end
        end
    end
end

return entity
