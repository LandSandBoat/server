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
    local skill = skillID
    local cap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill)
    local skillLevel = target:getCharSkillLevel(skill)
    local dif = (cap*10)/10 - (skillLevel*10)/100
    local randomCap = 1
    local skillGain = 0

    if dif > 100 then
        randomCap = 5
    elseif dif < 100 and dif >= 50 then
        randomCap = 4
    elseif dif < 50 and dif >= 20 then
        randomCap = 3
    elseif dif < 20 and dif >= 10 then
        randomCap = 2
    elseif dif < 10 then
        randomCap = 1
    end

    skillGain = math.random(1, randomCap)

    if dif <= 0 then
        return
    end

    target:messageBasic(38, skill, skillGain)
    
    if math.floor(skillLevel/10) < math.floor((skillLevel + skillGain)/10) then
        target:messageBasic(53, skill, skillLevel/10)
    end

    return target:setSkillLevel(skill, ((skillLevel + skillGain)/10)*10)
end