-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB: Namorodo
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/status")
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
    local personality = player:getFellowValue("personality")
    local fellow = player:getFellow()
    if fellow ~= nil then
        player:showText(fellow, ID.text.SEEMS_TO_BE_THE_END + xi.fellow_utils.checkPersonality(personality))
        player:setCharVar("[Quest]Looking_Glass", 3)
        player:timer(30000, function(playerArg)
            playerArg:despawnFellow()
        end) -- 30 sec to talk to fellow
    end
end

return entity
