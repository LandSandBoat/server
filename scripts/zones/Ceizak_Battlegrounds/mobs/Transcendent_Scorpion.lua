-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Transcendent Scorpion
-- !pos 160 0 -400 261
-- !additem 6013
-----------------------------------
---@type TMobEntity
local entity = {}

local removables = {
    xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.ELEGY, xi.effect.REQUIEM,
    xi.effect.PARALYSIS, xi.effect.POISON, xi.effect.DISEASE, xi.effect.PLAGUE,
    xi.effect.WEIGHT, xi.effect.BIND, xi.effect.BIO, xi.effect.DIA, xi.effect.BURN,
    xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
    xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN, xi.effect.MND_DOWN, xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW,
    xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN, xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN,
    xi.effect.MAX_MP_DOWN, xi.effect.MAX_HP_DOWN
}

local function removeSpecificDebuffs(mob)
    local numEffectsRemoved = 0
    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
            numEffectsRemoved = numEffectsRemoved + 1
        end
    end

return numEffectsRemoved
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 50 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 2022)
    elseif mob:getHPP() > 50 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 2021)
    end
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_USE', 'ALL_MOBSKILL_CHECK', function(mobArg, target, skillID, tp, action)
        local effectsRemoved = removeSpecificDebuffs(mob)
        if effectsRemoved > 0 then
            local hateList = mob:getEnmityList()
            for _, hateEntity in ipairs(hateList) do
                local player = hateEntity.entity
                if player and player:isPC() then
                    player:messageSpecial(zones[xi.zone.CEIZAK_BATTLEGROUNDS].text.SPRING_STEP)
                end
            end
        end
    end)
end

entity.onMobDeath = function(mob)
end

return entity
