require("scripts/globals/status")
require("scripts/globals/msg")

item_utils = {}

function item_utils.skillBookCheck(target, skillID)
    local skill = skillID
    local mainCap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill) or 0
    local subCap = target:getMaxSkillLevel(target:getSubLvl(), target:getSubJob(), skill) or 0
    local skillLevel = target:getCharSkillLevel(skill)/10
    local mainDif = (mainCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
    local subDif = (mainCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
    local noSkill = 0
    local canUse = 0

    if mainCap == 0 then
        noSkill = noSkill +1
    end

    if subCap == 0 then
        noSkill = noSkill +1  
    end

    if noSkill >= 2 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if mainCap > 0 and mainDif <= 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if subCap > 0 and mainCap == 0 and subDif <= 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

function item_utils.skillBookUse(target, skillID)
    target:trySkillUp(skillID, target:getMainLvl(), true)
end