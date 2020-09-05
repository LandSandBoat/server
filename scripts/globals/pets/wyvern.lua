-----------------------------------
--  PET: Wyvern
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

local WYVERN_OFFENSIVE = 1
local WYVERN_DEFENSIVE = 2
local WYVERN_MULTI = 3

local wyvernTypes = {
    [tpz.job.WAR] = WYVERN_OFFENSIVE,
    [tpz.job.MNK] = WYVERN_OFFENSIVE,
    [tpz.job.WHM] = WYVERN_DEFENSIVE,
    [tpz.job.BLM] = WYVERN_DEFENSIVE,
    [tpz.job.RDM] = WYVERN_DEFENSIVE,
    [tpz.job.THF] = WYVERN_OFFENSIVE,
    [tpz.job.PLD] = WYVERN_MULTI,
    [tpz.job.DRK] = WYVERN_MULTI,
    [tpz.job.BST] = WYVERN_OFFENSIVE,
    [tpz.job.BRD] = WYVERN_MULTI,
    [tpz.job.RNG] = WYVERN_OFFENSIVE,
    [tpz.job.SAM] = WYVERN_OFFENSIVE,
    [tpz.job.NIN] = WYVERN_MULTI,
    [tpz.job.DRG] = WYVERN_OFFENSIVE,
    [tpz.job.SMN] = WYVERN_DEFENSIVE,
    [tpz.job.BLU] = WYVERN_DEFENSIVE,
    [tpz.job.COR] = WYVERN_OFFENSIVE,
    [tpz.job.PUP] = WYVERN_OFFENSIVE,
    [tpz.job.DNC] = WYVERN_OFFENSIVE,
    [tpz.job.SCH] = WYVERN_DEFENSIVE,
    [tpz.job.GEO] = WYVERN_DEFENSIVE,
    [tpz.job.RUN] = WYVERN_MULTI
}

function doHealingBreath(player, threshold, breath)
    local breath_heal_range = 13
    local function inBreathRange(target)
        return player:getPet():getZoneID() == target:getZoneID() and player:getPet():checkDistance(target) <= breath_heal_range
    end

    if player:getHPP() < threshold and inBreathRange(player) then
        player:getPet():useJobAbility(breath, player)
    else
        local party = player:getParty()
        for _, member in ipairs(party) do
            if member:getHPP() < threshold and inBreathRange(member) then
                player:getPet():useJobAbility(breath, member)
                break
            end
        end
    end
end

function onMobSpawn(mob)
    local master = mob:getMaster()
    mob:addMod(tpz.mod.DMG, -40)
    local wyvernType = wyvernTypes[master:getSubJob()]
    local healingbreath = 624
    if mob:getMainLvl() >= 80 then healingbreath = 623
    elseif mob:getMainLvl() >= 40 then healingbreath = 626
    elseif mob:getMainLvl() >= 20 then healingbreath = 625 end
    if wyvernType == WYVERN_DEFENSIVE then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            local party = player:getParty()
            for _, member in ipairs(party) do
                if member:hasStatusEffect(tpz.effect.POISON) then
                    player:getPet():useJobAbility(627, member)
                    break
                elseif member:hasStatusEffect(tpz.effect.BLINDNESS) and player:getPet():getMainLvl() > 20 then
                    player:getPet():useJobAbility(628, member)
                    break
                elseif member:hasStatusEffect(tpz.effect.PARALYSIS) and player:getPet():getMainLvl() > 40 then
                    player:getPet():useJobAbility(629, member)
                    break
                elseif (member:hasStatusEffect(tpz.effect.CURSE_I) or member:hasStatusEffect(tpz.effect.DOOM)) and player:getPet():getMainLvl() > 60 then
                    player:getPet():useJobAbility(637, member)
                    break
                elseif (member:hasStatusEffect(tpz.effect.DISEASE) or member:hasStatusEffect(tpz.effect.PLAGUE)) and player:getPet():getMainLvl() > 80 then
                    player:getPet():useJobAbility(638, member)
                    break
                end
            end
        end)
        if master:getSubJob() ~= tpz.job.SMN then
            master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
                -- check master first!
                local threshold = 33
                if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                    threshold = 50
                end
                doHealingBreath(player, threshold, healingbreath)
            end)
        end
    elseif wyvernType == WYVERN_OFFENSIVE or wyvernType == WYVERN_MULTI then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            local weaknessTargetChance = 75
            local breaths = {}
            if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                weaknessTargetChance = 100
            end
            if math.random(100) <= weaknessTargetChance then
                local weakness = 0
                for mod = 0, 5 do
                    if target:getMod(tpz.mod.FIREDEF + mod) < target:getMod(tpz.mod.FIREDEF + weakness) then
                        breaths = {}
                        table.insert(breaths, 630 + mod)
                    elseif target:getMod(tpz.mod.FIREDEF + mod) == target:getMod(tpz.mod.FIREDEF + weakness) then
                        table.insert(breaths, 630 + mod)
                    end
                end
            else
                breaths = {630, 631, 632, 633, 634, 635}
            end
            player:getPet():useJobAbility(breaths[math.random(#breaths)], target)
        end)
    end
    if wyvernType == WYVERN_MULTI then
        master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
            -- check master first!
            local threshold = 25
            if player:getMod(tpz.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                threshold = 33
            end
            doHealingBreath(player, threshold, healingbreath)
        end)
    end

    master:addListener("ATTACK", "PET_WYVERN_ENGAGE", function(player, target, action)
        local pet = player:getPet()
        if pet:getTarget() == nil or target:getID() ~= pet:getTarget():getID() then
            player:petAttack(target)
        end
    end)

    master:addListener("DISENGAGE", "PET_WYVERN_DISENGAGE", function(player)
        player:petRetreat()
    end)

    master:addListener("EXPERIENCE_POINTS", "PET_WYVERN_EXP", function(player, exp)
        local pet = player:getPet()
        local prev_exp = pet:getLocalVar("wyvern_exp")
        if prev_exp < 1000 then
        -- cap exp at 1000 to prevent wyvern leveling up many times from large exp awards
            local currentExp = exp
            if prev_exp+exp > 1000 then
                currentExp = 1000 - prev_exp
            end
            local diff = math.floor((prev_exp + currentExp)/200) - math.floor(prev_exp/200)
            if diff ~= 0 then
                -- wyvern levelled up (diff is the number of level ups)
                pet:addMod(tpz.mod.ACC, 6*diff)
                pet:addMod(tpz.mod.HPP, 6*diff)
                pet:addMod(tpz.mod.ATTP, 5*diff)
                pet:setHP(pet:getMaxHP())
                player:messageBasic(tpz.msg.basic.STATUS_INCREASED, 0, 0, pet)
                master:addMod(tpz.mod.ATTP, 4 * diff)
                master:addMod(tpz.mod.DEFP, 4 * diff)
                master:addMod(tpz.mod.HASTE_ABILITY, 200 * diff)
            end
            pet:setLocalVar("wyvern_exp", prev_exp + exp)
            pet:setLocalVar("level_Ups", pet:getLocalVar("level_Ups") + diff)
        end
    end)
end

function onMobDeath(mob, player)
    local master = mob:getMaster()
    local numLvls = mob:getLocalVar("level_Ups")
    if numLvls ~= 0 then
        master:delMod(tpz.mod.ATTP, 4 * numLvls)
        master:delMod(tpz.mod.DEFP, 4 * numLvls)
        master:delMod(tpz.mod.HASTE_ABILITY, 200 * numLvls)
    end
    master:removeListener("PET_WYVERN_WS")
    master:removeListener("PET_WYVERN_MAGIC")
    master:removeListener("PET_WYVERN_ENGAGE")
    master:removeListener("PET_WYVERN_DISENGAGE")
    master:removeListener("PET_WYVERN_EXP")
end
