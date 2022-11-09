-----------------------------------
-- func: getskill <skill name or ID> <target>
-- desc: returns target's level of specified skill
-----------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getskill <skill name or ID> (player)")
end

function onTrigger(player, skillName, target)
    if skillName == nil then
        error(player, "You must specify a skill to check!")
        return
    end

    local skillID = tonumber(skillName) or xi.skill[string.upper(skillName)]
    local targ = nil

    if
        skillID == nil or
        skillID == 0 or
        (skillID > 12 and skillID < 25) or
        skillID == 46 or
        skillID == 47 or
        skillID > 57
    then
        error(player, "You must specify a valid skill.")
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

    -- Trying to break this wide line in any other more reasonable way results in lua throwing errors.. Parsing bug.
    player:PrintToPlayer(string.format("%s's current skillID '%s' Skill: %s (real value: %s)",
    targ:getName(), skillName, (targ:getCharSkillLevel(skillID) / 10) .. ".x", targ:getCharSkillLevel(skillID)))
end
