-----------------------------------
-- func: setskill <skill name or ID> <skill level> <target>
-- desc: sets target's level of specified skill
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setskill <skill name or ID> <skill level> {player}")
end

function onTrigger(player, skillName, skillLV, target)
    if (skillName == nil) then
        error(player, "You must specify a skill to set!")
        return
    end

    if skillLV == nil then
        error(player, "You must specify the new skill level to set.")
        return
    end


    local skillID = tonumber(skillName) or xi.skill[string.upper(skillName)]
    local targ

    if skillID == nil or skillID == 0 or (skillID > 12 and skillID < 25)
    or skillID == 46 or skillID == 47 or skillID > 57 then
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

    targ:setSkillLevel(skillID, skillLV*10)
    targ:messageBasic(xi.msg.basic.SKILL_REACHES_LEVEL, skillID, skillLV)

    if targ ~= player then
        player:PrintToPlayer(string.format("%s's new skillID '%s' Skill: %s", targ:getName(), skillName, (targ:getCharSkillLevel(skillID)/10)..".0"))
    end
end
