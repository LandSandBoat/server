---------------------------------------------------------------------------------------------------
-- func: getstats
-- desc: prints stats of cursor target into chatlog, for debugging.
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

cmdprops =
{
    permission = 1,
    parameters = ""
}

-- function onTrigger(player, extendedMode)
function onTrigger(player)
    local target = player:getCursorTarget()
    if target == nil then
        player:PrintToPlayer("Target something first.")
        return
    end

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:PrintToPlayer("Target something other than an NPC..They don't have stats!")
        return
    end

    player:PrintToPlayer(string.format("MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ",
        target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), xi.msg.channel.SYSTEM_3)

    player:PrintToPlayer(string.format("HP: %i/%i  MP: %i/%i (current/max) ",
        target:getHP(), target:getMaxHP(), target:getMP(), target:getMaxMP()), xi.msg.channel.SYSTEM_3)

    player:PrintToPlayer(string.format("Food Accuracy%% bonus: %i ", target:getMod(xi.mod.FOOD_ACCP)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Accuracy bonus: %i ", target:getMod(xi.mod.ACC)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("EVA Bonus: %i ", target:getMod(xi.mod.EVA)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total STR: %i ", target:getStat(xi.mod.STR)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total DEX: %i ", target:getStat(xi.mod.DEX)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total VIT: %i ", target:getStat(xi.mod.VIT)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total AGI: %i ", target:getStat(xi.mod.AGI)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total MND: %i ", target:getStat(xi.mod.MND)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total INT: %i ", target:getStat(xi.mod.INT)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total CHR: %i ", target:getStat(xi.mod.CHR)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Attack bonus: %i ", target:getMod(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total Attack: %i ", target:getStat(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Defense bonus: %i ", target:getMod(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Total Defense: %i ", target:getStat(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Magic Attack bonus: %i ", target:getMod(xi.mod.MATT)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Magic Defense bonus: %i ", target:getMod(xi.mod.MDEF)), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Magic Accuracy bonus: %i ", target:getMod(xi.mod.MACC)), xi.msg.channel.SYSTEM_3)
    -- player:PrintToPlayer(string.format("Total Subtle Blow: %i ", target:getMod(xi.mod.SUBTLE_BLOW)), xi.msg.channel.SYSTEM_3)
    -- player:PrintToPlayer(string.format("Total Store TP: %i ", target:getMod(xi.mod.STORETP)), xi.msg.channel.SYSTEM_3)
    -- player:PrintToPlayer("Cannot easily and accurately get Magic Evasion with current methods.")

    if targetType == xi.objType.PC then
        player:PrintToPlayer(string.format("%s's base Treasure Hunter w/current equipment: %i",
        target:getName(), target:getMod(xi.mod.TREASURE_HUNTER)), xi.msg.channel.SYSTEM_3)
    elseif targetType == xi.objType.PET then
        -- not needed yet, but we don't want to run MOB so just die in empty conditionals
    elseif targetType == xi.objType.TRUST then
        -- see above
    elseif targetType == xi.objType.FELLOW then
        -- see above
    elseif targetType == xi.objType.MOB then
        player:PrintToPlayer(string.format("Mob's current Treasure Hunter Tier: %i", target:getTHlevel()), xi.msg.channel.SYSTEM_3)
        player:PrintToPlayer(string.format("Battletime: %i ", target:getBattleTime()), xi.msg.channel.SYSTEM_3)
        -- Todo: check if raged and/or how long mobs ragetimer is.
    end

    --[[ future use: print resistances etc..
    if extendedMode then
        -- That'll be pretty spammy.. Maybe NOT print everything and make it a choice which "page" of stats to print.
    end
    ]]
end
