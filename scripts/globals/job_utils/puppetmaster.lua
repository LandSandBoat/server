-----------------------------------
-- Puppetmaster Job Utilities
-----------------------------------
require('scripts/globals/ability')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.puppetmaster = xi.job_utils.puppetmaster or {}
-----------------------------------

local removableEffects =
{
    -- Songs
    xi.effect.ELEGY,
    xi.effect.REQUIEM,
    xi.effect.THRENODY,

    -- Enfeebling
    xi.effect.BLINDNESS,
    xi.effect.PARALYSIS,
    xi.effect.SILENCE,
    xi.effect.CURSE_I,
    xi.effect.CURSE_II,
    xi.effect.DISEASE,
    xi.effect.PLAGUE,
    xi.effect.WEIGHT,
    xi.effect.BIND,
    xi.effect.ADDLE,
    xi.effect.SLOW,
    xi.effect.PETRIFICATION,

    -- DoTs
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.POISON,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,

    -- Main Stat Downs
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,

    -- Combat Stat Downs
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,

    -- Magic Stat Downs
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN,
    xi.effect.MAGIC_DEF_DOWN,

    -- HP/MP/TP Stat Downs
    xi.effect.MAX_TP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.MAX_HP_DOWN
}

-- Removes status effects from the pet based on the amount passed to this function.
local function removeStatusEffects(pet, amountToRemove)
    local effectsRemoved = 0

    for _, effectId in ipairs(removableEffects) do
        if effectsRemoved >= amountToRemove then
            break
        end

        if pet:delStatusEffect(effectId) then
            effectsRemoved = effectsRemoved + 1
        end
    end

    return effectsRemoved
end

-- https://www.bg-wiki.com/ffxi/Repair
-- https://www.bg-wiki.com/ffxi/Maintenance
xi.job_utils.puppetmaster.oilData =
{
    [xi.item.CAN_OF_AUTOMATON_OIL   ] = { initialHealPercent = 0.1, statusesRemoved = 1, regen = 20, duration = 15 },
    [xi.item.CAN_OF_AUTOMATON_OIL_P1] = { initialHealPercent = 0.2, statusesRemoved = 2, regen = 40, duration = 30 },
    [xi.item.CAN_OF_AUTOMATON_OIL_P2] = { initialHealPercent = 0.3, statusesRemoved = 3, regen = 60, duration = 45 },
    [xi.item.CAN_OF_AUTOMATON_OIL_P3] = { initialHealPercent = 0.4, statusesRemoved = 4, regen = 80, duration = 60 },
}

-----------------------------------
-- Overdrive - Augments the fighting ability of your automaton to its maximum level.
-----------------------------------

-- On Ability Check Overdrive
xi.job_utils.puppetmaster.onAbilityCheckOverdrive = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
        return 0, 0
    end
end

-- On Ability Use Overdrive
xi.job_utils.puppetmaster.onAbilityUseOverdrive = function(player, target, ability, action)
    local pet = player:getPet()

    player:addStatusEffect(xi.effect.OVERDRIVE, { duration = 180 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = player })

    if pet then
        pet:addStatusEffect(xi.effect.OVERDRIVE, { duration = 180 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = pet })
        action:ID(player:getID(), pet:getID())
    end

    return xi.effect.OVERDRIVE
end

-----------------------------------
-- Activate - Calls forth your automaton
-----------------------------------

-- On Ability Check Activate
xi.job_utils.puppetmaster.onAbilityCheckActivate = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    elseif player:isExceedingElementalCapacity() then
        return xi.msg.basic.AUTO_EXCEEDS_CAPACITY, 0
    end

    return 0, 0
end

-- On Ability Use Activate
xi.job_utils.puppetmaster.onAbilityUseActivate = function(player, target, ability)
    xi.pet.spawnPet(player, xi.petId.AUTOMATON)

    local pet = player:getPet()

    if pet then
        local jpValue = player:getJobPointLevel(xi.jp.AUTOMATON_HP_MP_BONUS)
        pet:addMod(xi.mod.HP, jpValue * 10)
        pet:addMod(xi.mod.MP, jpValue * 5)
        pet:updateHealth()

        -- ensure it spawns at full hp
        pet:addHP(pet:getMod(xi.mod.HP))
        pet:addMP(pet:getMod(xi.mod.MP))
    end
end

-----------------------------------
-- Deus Ex Automata - Calls forth your automaton in an unsound state.
-----------------------------------

-- On Ability Check Deus Ex Automata
xi.job_utils.puppetmaster.onAbilityCheckDeusExAutomata = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        local jpValue = player:getJobPointLevel(xi.jp.DEUS_EX_AUTOMATA_RECAST)

        ability:setRecast(ability:getRecast() - jpValue)

        return 0, 0
    end
end

-- On Ability Use Deus Ex Automata
xi.job_utils.puppetmaster.onAbilityUseDeusExAutomata = function(player, target, ability)
    xi.pet.spawnPet(player, xi.petId.AUTOMATON)
    local pet = player:getPet()

    if pet then
        local jpValue = player:getJobPointLevel(xi.jp.AUTOMATON_HP_MP_BONUS)
        pet:addMod(xi.mod.HP, jpValue * 10)
        pet:addMod(xi.mod.MP, jpValue * 5)
        pet:updateHealth()

        -- ensure it spawns at specific HPP/MPP based on level
        local percent = math.floor((player:getMainLvl() / 3)) / 100
        pet:setHP(math.max(pet:getMaxHP() * percent, 1))
        pet:setMP(pet:getMaxMP() * percent)
    end
end

-----------------------------------
-- Repair - Gradually restores your automaton's HP. Special items required. (Oil)
-----------------------------------

-- On Ability Check Repair
xi.job_utils.puppetmaster.onAbilityCheckRepair = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    elseif pet:checkDistance(player) > 20.0 + player:getHitboxSize() + pet:getHitboxSize() then
        return xi.msg.basic.TOO_FAR_AWAY_2, 0
    else
        local id = player:getEquipID(xi.slot.AMMO)

        if xi.job_utils.puppetmaster.oilData[id] then
            return 0, 0
        else
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        end
    end
end

-- On Ability Use Repair
xi.job_utils.puppetmaster.onAbilityUseRepair = function(player, target, ability, action)
    local pet = player:getPet()
    if not pet then
        return
    end

    -- Self-cast ability but reports on pet
    action:ID(player:getID(), pet:getID())

    local petMaxHP = pet:getMaxHP()

    -- Need to start to calculate the HP to restore to the pet.
    -- Ref: https://www.bg-wiki.com/ffxi/Repair
    local oilEquipped  = xi.job_utils.puppetmaster.oilData[player:getEquipID(xi.slot.AMMO)]
    local regenAmount  = oilEquipped.regen
    local totalHealing = oilEquipped.initialHealPercent * petMaxHP
    local regenTime    = oilEquipped.duration

    removeStatusEffects(pet, player:getMod(xi.mod.REPAIR_EFFECT))

    local bonus  = 1 + player:getMerit(xi.merit.REPAIR_EFFECT) / 100
    totalHealing = totalHealing * bonus

    bonus       = bonus + player:getMod(xi.mod.REPAIR_POTENCY) / 100
    regenAmount = regenAmount * bonus

    totalHealing = pet:addHP(totalHealing)

    pet:wakeUp()

    pet:delStatusEffect(xi.effect.REGEN)
    pet:addStatusEffect(xi.effect.REGEN, { power = regenAmount, duration = regenTime, origin = player, tick = 3 }) -- 3 = tick, each 3 seconds.
    player:removeAmmo(1)
    return totalHealing
end

-----------------------------------
-- Maintenance - Cures your automaton of status ailments. Special items required.
-----------------------------------

-- On Ability Check Maintenance
xi.job_utils.puppetmaster.onAbilityCheckMaintenance = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        local id = player:getEquipID(xi.slot.AMMO)
        if xi.job_utils.puppetmaster.oilData[id] then
            return 0, 0
        else
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        end
    end
end

-- On Ability Use Maintenance
xi.job_utils.puppetmaster.onAbilityUseMaintenance = function(player, target, ability)
    local pet            = player:getPet()
    local oilEquipped    = xi.job_utils.puppetmaster.oilData[player:getEquipID(xi.slot.AMMO)]
    local effectsRemoved = removeStatusEffects(pet, oilEquipped.statusesRemoved)

    player:removeAmmo(1)

    return effectsRemoved
end

-----------------------------------
-- Role Reversal - Swaps the Master's current HP with the Automaton's current HP.
-----------------------------------

-- On Ability Check Role Reversal
xi.job_utils.puppetmaster.onAbilityCheckRoleReversal = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

-- On Ability Use Role Reversal
xi.job_utils.puppetmaster.onAbilityUseRoleReversal = function(player, target, ability)
    local pet = player:getPet()
    if pet then
        local bonus    = 1 + (player:getMerit(xi.merit.ROLE_REVERSAL) - 5) / 100
        local playerHP = player:getHP()
        local petHP    = pet:getHP()

        pet:setHP(math.max(playerHP * bonus, 1))
        player:setHP(math.max(petHP * bonus, 1))
    end
end

-----------------------------------
-- Ventriloquy - Swaps the enmity of the current target between master and automaton.
-----------------------------------

-- On Ability Check Ventriloquy
xi.job_utils.puppetmaster.onAbilityCheckVentriloquy = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    end

    return 0, 0
end

-- On Ability Use Ventriloquy
xi.job_utils.puppetmaster.onAbilityUseVentriloquy = function(player, target, ability)
    local pet = player:getPet()
    if pet then
        local enmitylist            = target:getEnmityList()
        local playerfound, petfound = false, false

        for k, v in pairs(enmitylist) do
            if v.entity:getTargID() == player:getTargID() then
                playerfound = true
            elseif v.entity:getTargID() == pet:getTargID() then
                petfound = true
            end
        end

        if playerfound and petfound then
            local bonus             = (player:getMerit(xi.merit.VENTRILOQUY) - 5) / 100
            local playerCE          = target:getCE(player)
            local playerVE          = target:getVE(player)
            local petCE             = target:getCE(pet)
            local petVE             = target:getVE(pet)
            local playerEnmityBonus = 1
            local petEnmityBonus    = 1

            if
                target:getTarget():getTargID() == player:getTargID() or
                ((playerCE + playerVE) >= (petCE + petVE) and target:getTarget():getTargID() ~= pet:getTargID())
            then
                playerEnmityBonus = playerEnmityBonus + bonus
                petEnmityBonus    = petEnmityBonus - bonus
            else
                playerEnmityBonus = playerEnmityBonus - bonus
                petEnmityBonus    = petEnmityBonus + bonus
            end

            target:setCE(player, petCE * petEnmityBonus)
            target:setVE(player, petVE * petEnmityBonus)
            target:setCE(pet, playerCE * playerEnmityBonus)
            target:setVE(pet, playerVE * playerEnmityBonus)
        end
    end
end

-----------------------------------
-- Tactical Switch - Swaps Master's current TP with Automaton's current TP.
-----------------------------------

-- On Ability Check Tactical Switch
xi.job_utils.puppetmaster.onAbilityCheckTacticalSwitch = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

-- On Ability Use Tactical Switch
xi.job_utils.puppetmaster.onAbilityUseTacticalSwitch = function(player, target, ability, action)
    local pet                 = player:getPet()
    local currentPlayerTP     = player:getTP()
    local currentPetTP        = pet:getTP()
    local tacticalSwitchBonus = 1 + player:getMod(xi.mod.TACTICAL_SWITCH_TP_BONUS) / 100
    local jobPointBonus       = player:getJobPointLevel(xi.jp.TACTICAL_SWITCH_BONUS) * 20
    local playerNewTP         = math.min(3000, math.floor(currentPetTP * tacticalSwitchBonus) + jobPointBonus)
    local automatonNewTP      = math.min(3000, math.floor(currentPlayerTP * tacticalSwitchBonus))

    player:setTP(playerNewTP)
    pet:setTP(automatonNewTP)

    action:ID(player:getID(), pet:getID())
end

-----------------------------------
-- Cooldown - Reduces the strain on your automaton.
-----------------------------------

-- On Ability Check Cooldown
xi.job_utils.puppetmaster.onAbilityCheckCooldown = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    end

    return 0, 0
end

-- On Ability Use Cooldown
xi.job_utils.puppetmaster.onAbilityUseCooldown = function(player, target, ability)
    local jpValue = player:getJobPointLevel(xi.jp.COOLDOWN_EFFECT)

    player:reduceBurden(50, jpValue)

    if player:hasStatusEffect(xi.effect.OVERLOAD) then
        player:delStatusEffect(xi.effect.OVERLOAD)
    end
end

-- On Ability Check Heady Artiface
xi.job_utils.puppetmaster.onAbilityCheckHeadyArtiface = function(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

        return 0, 0
    end
end

-----------------------------------
-- Heady Artifice - Allows automatons to perform a special ability that varies with the head used.
-----------------------------------

-- On Ability Use Heady Artifice
xi.job_utils.puppetmaster.onAbilityUseHeadyArtifice = function(player, target, ability, action)
    local pet = player:getPet()

    if pet then
        pet:setLocalVar('headyArtificeUsed', 1)

        action:ID(player:getID(), pet:getID())
    end
end

-----------------------------------
-- Deploy - Orders your automaton to attack.
-----------------------------------

-- On Ability Check Deploy
xi.job_utils.puppetmaster.onAbilityCheckDeploy = function(player, target, ability)
    return 0, 0
end

-- On Ability Use Deploy
xi.job_utils.puppetmaster.onAbilityUseDeploy = function(player, target, ability)
    player:petAttack(target)
end

-----------------------------------
-- Retrieve - Orders your automaton to return to your side.
-----------------------------------

-- On Ability Check Retrieve
xi.job_utils.puppetmaster.onAbilityCheckRetrieve = function(player, target, ability)
    return 0, 0
end

-- On Ability Use Retrieve
xi.job_utils.puppetmaster.onAbilityUseRetrieve = function(player, target, ability)
    player:petRetreat()
end

-----------------------------------
-- Deactivate - Deactivates your automaton.
-----------------------------------

-- On Ability Check Deactivate
xi.job_utils.puppetmaster.onAbilityCheckDeactivate = function(player, target, ability)
    return 0, 0
end

-- On Ability Use Deactivate
xi.job_utils.puppetmaster.onAbilityUseDeactivate = function(player, target, ability)
    -- Reset the Activate ability.
    local pet = player:getPet()

    if
        pet and
        pet:getHP() == pet:getMaxHP()
    then
        player:resetRecast(xi.recast.ABILITY, xi.recastID.ACTIVATE)
    end

    target:despawnPet()
end
