-----------------------------------
-- func: setcraftRank <craft skill or ID> <craft rank> <target>
-- desc: sets target's RANK of specified craft skill
-----------------------------------
cmdprops =
{
    permission = 1,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setcraftRank <craft skill or ID> <craft rank> (player)")
end

function onTrigger(player, craftName, tier, target)
    if craftName == nil then
        error(player, "You must specify a craft skill to set!")
        return
    end

    local skillID = tonumber(craftName) or xi.skill[string.upper(craftName)]
    local targ = nil

    if skillID == nil or skillID < 48 or skillID > 57 then
        error(player, "You must specify a valid craft skill.")
        return
    end

    if tier == nil then
        error(player, "You must specify a rank to set the craft skill to.")
        return
    end

    local craftRank = tonumber(tier) or xi.craftRank[string.upper(tier)]
    if craftRank == nil then
        error(player, "Invalid craft rank!")
        return
    end

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, "You must target a player or specify a name.")
                return
            end
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            player:PrintToPlayer(string.format("Player named '%s' not found!", target))
            return
        end
    end

    targ:setSkillRank(skillID, craftRank)
    targ:PrintToPlayer(string.format("Your %s craft skill rank has been adjusted to: %s", craftName, craftRank))
    if targ ~= player then
        player:PrintToPlayer(string.format("%s's new skillID '%s' rank: %u", targ:getName(), craftName, targ:getSkillRank(skillID)))
    end
end
