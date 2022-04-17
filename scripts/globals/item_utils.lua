-----------------------------------
-- Item Utils (Used by Skill Books)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.item_utils = {}

xi.item_utils.skillBookCheck = function(target, skillID)
    local skill = skillID
    local mainCap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill) or 0
    local subCap = target:getMaxSkillLevel(target:getSubLvl(), target:getSubJob(), skill) or 0
    local mainDif = (mainCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
    local subDif = (subCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
    local noSkill = 0

    if mainCap == 0 then
        noSkill = noSkill + 1
    end

    if subCap == 0 then
        noSkill = noSkill + 1
    end

    if noSkill >= 2 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if mainCap > 0 and mainDif <= 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if subCap > 0 and mainCap == 0 and subDif <= 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

xi.item_utils.skillBookUse = function(target, skillID)
    target:trySkillUp(skillID, target:getMainLvl(), true, true)
end
