-----------------------------------
-- Area: Ghelsba Outpost
--  MOB: Carrion Dragon
-- Involved in Quest: Mirror Mirror
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
end

entity.onMobFight = function(mob, target)
    if
        mob:getHPP() <= 75 and
        mob:getID() == ID.mob.CARRION_DRAGON and
        mob:getLocalVar("CS_Lock") == 0
    then
        -- Disable the dragon
        mob:setLocalVar("CS_Lock", 1)
        SetServerVariable("[Mirror_Mirror]BCNMmobHP", mob:getHP())
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)

        local players = mob:getBattlefield():getPlayers()
        for i, player in pairs(players) do
            player:disengage()
            local fellowParam = xi.fellow_utils.getFellowParam(player)
            player:startEvent(32004, 140, 0, 5, 0, 0, 0, 0, fellowParam)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
