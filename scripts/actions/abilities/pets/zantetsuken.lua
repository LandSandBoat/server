-----------------------------------
-- Zantetsuken
-- Family: Odin (Player Pet)
-- Notes: Requires Astral Flow to be active.
-- TODO: Ability Needs captures/audit.
-- https://wiki.ffo.jp/html/17522.html

-- Wanna bet this is made up?
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    if summoner == nil then
        return 0
    end

    local returnParam = 0
    local power       = summoner:getMP() / utils.clamp(summoner:getMaxMP(), 1, 9999)

    summoner:delStatusEffect(xi.effect.ASTRAL_FLOW)

    if target:isNM() then
        local params = {}

        params.baseDamage      = power
        params.element         = xi.element.DARK
        params.attackType      = xi.attackType.MAGICAL
        params.damageType      = xi.damageType.DARK
        params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
        params.canMagicBurst   = true
        params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

        local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

        if xi.mobskills.processDamage(pet, target, petskill, action, info) then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
        end

        returnParam = info.damage
    else
        -- Zantetsuken chance to kill starts at MP/MaxMP so at full MP the kill chance is 100%
        -- This is then divided by the number of targets. So with 4 targets, each one has a 25%
        -- to die if the summoner has full MP. I am guessing at the 1% floor with 100 targets.
        -- I have never tested this against more than 5-6 targets on retail.
        local chance = 100 * power / utils.clamp(petskill:getTotalTargets(), 1, 100)

        if
            math.randomInt(1, 100) <= chance and
            target:getAnimation() ~= 33
        then
            target:takeDamage(target:getHP(), pet, xi.attackType.MAGICAL, xi.damageType.DARK)

            returnParam = xi.effect.KO
        else
            petskill:setMsg(xi.msg.basic.EVADES)

            returnParam = 0
        end
    end

    summoner:setMP(0)

    -- Despawn Odin after 8 seconds.
    pet:timer(8000, function()
        if summoner then
            summoner:despawnPet()
        end
    end)

    return returnParam
end

return abilityObject
