-----------------------------------
-- func: spawnfellow
-- desc: Spawns a player's Adventuring Fellow if they have one.
--       Primarily used for testing to bypass pearl cooldowns.
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!spawnFellow - no params, works on self only")
end

function onTrigger(player)
    if player:getFellow() ~= nil then
        error(player, "Player already has a fellow.")
        return
    end

    if
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) or
        player:hasStatusEffect(xi.effect.LEVEL_SYNC)
    then
        error(player, "Player is under Level Sync or Level Restriction.")
        return
    end

    if
        xi.settings.main.ENABLE_ADVENTURING_FELLOWS == nil or
        not xi.settings.main.ENABLE_ADVENTURING_FELLOWS
    then
        error(player, "Fellows are disabled via server settings.")
        return
    end

    if not player:canUseMisc(xi.zoneMisc.FELLOW) then
        error(player, "Fellows are not allowed in this zone via zone settings misc.")
        return
    end

    if player:getFellowValue("fellowid") == 0 then
        error(player, "Player does not have a fellow.")
        return
    end

    player:spawnFellow(player:getFellowValue("fellowid"))
    player:PrintToPlayer("Spawned Adventuring Fellow")
end
