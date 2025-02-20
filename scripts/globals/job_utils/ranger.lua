-----------------------------------
-- Ranger Job Utilities
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.ranger = xi.job_utils.ranger or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------

xi.job_utils.ranger.checkEagleEyeShot = function(player, target, ability)
    local ranged = player:getStorageItem(0, 0, xi.slot.RANGED)
    local ammo   = player:getStorageItem(0, 0, xi.slot.AMMO)

    if ranged and ranged:isType(xi.itemType.WEAPON) then
        local skilltype = ranged:getSkillType()
        if
            skilltype == xi.skill.ARCHERY or
            skilltype == xi.skill.MARKSMANSHIP or
            skilltype == xi.skill.THROWING
        then
            if
                ammo and
                (
                    ammo:isType(xi.itemType.WEAPON) or
                    skilltype == xi.skill.THROWING
                )
            then
                ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
                return 0, 0
            end
        end
    end

    return xi.msg.basic.NO_RANGED_WEAPON, 0
end

xi.job_utils.ranger.checkVelocityShot = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkSharpshot = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkScavenge = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkCamouflage = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkBarrage = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkShadowbind = function(player, target, ability)
    if
        (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP and
        player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.MARKSMANSHIP) or
        (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.ARCHERY and
        player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.ARCHERY)
    then
        return 0, 0
    end

    return 216, 0 -- You do not have an appropriate ranged weapon equipped.
end

xi.job_utils.ranger.checkUnlimitedShot = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkFlashyShot = function(player, target, ability)
    return 0, 0 -- Not implemented yet
end

xi.job_utils.ranger.checkStealthShot = function(player, target, ability)
    return 0, 0 -- Not implemented yet
end

xi.job_utils.ranger.checkDoubleShot = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkBountyShot = function(player, target, ability)
    if target:getObjType() ~= xi.objType.MOB then
        return xi.msg.basic.CANNOT_ATTACK_TARGET, 0
    end

    if
        (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP and
        player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.MARKSMANSHIP) or
        (player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.ARCHERY and
        player:getWeaponSkillType(xi.slot.AMMO) == xi.skill.ARCHERY)
    then
        return 0, 0
    end

    return xi.msg.basic.NO_RANGED_WEAPON, 0
end

xi.job_utils.ranger.checkDecoyShot = function(player, target, ability)
    return 0, 0
end

xi.job_utils.ranger.checkHoverShot = function(player, target, ability)
    return 0, 0  -- Not implemented yet
end

xi.job_utils.ranger.checkOverkill = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------

xi.job_utils.ranger.useEagleEyeShot = function(player, target, ability, action)
    if player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP then
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local params = {}

    params.numHits = 1

    -- TP params.
    local tp          = 1000 -- to ensure ftp multiplier is applied
    params.ftpMod     = { 5.0, 5.0, 5.0 }
    params.critVaries = { 0.0, 0.0, 0.0 }

    -- Stat params.
    params.str_wsc = 0
    params.dex_wsc = 0
    params.vit_wsc = 0
    params.agi_wsc = 0
    params.int_wsc = 0
    params.mnd_wsc = 0
    params.chr_wsc = 0

    params.enmityMult = 0.5

    -- Job Point Bonus Damage
    local jpValue = player:getJobPointLevel(xi.jp.EAGLE_EYE_SHOT_EFFECT)
    player:addMod(xi.mod.ALL_WSDMG_ALL_HITS, jpValue * 3)

    local damage, _, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, 0, params, tp, action, true)

    -- Set the message id ourselves
    if tpHits + extraHits > 0 then
        action:messageID(target:getID(), xi.msg.basic.JA_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage
end

xi.job_utils.ranger.useVelocityShot = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.VELOCITY_SHOT, 1, 0, 7200)
end

xi.job_utils.ranger.useSharpshot = function(player, target, ability, action)
    local power = 40 + player:getMod(xi.mod.SHARPSHOT)
    player:addStatusEffect(xi.effect.SHARPSHOT, power, 0, 60)
end

xi.job_utils.ranger.useScavenge = function(player, target, ability, action)
    -- RNG AF2 quest check
    local fireAndBrimstoneCS = player:getCharVar('fireAndBrimstone')

    if
        player:getZoneID() == xi.zone.CASTLE_OZTROJA and fireAndBrimstoneCS == 5 and-- zone + quest match
        not player:hasItem(xi.item.OLD_EARRING) and -- make sure player doesn't already have the earring
        player:getYPos() > -43 and player:getYPos() < -38 and -- Y match
        player:getXPos() > -85 and player:getXPos() < -73 and -- X match
        player:getZPos() > -85 and player:getZPos() < -75 and -- Z match
        math.random(1, 100) <= 50
    then
        npcUtil.giveItem(player, xi.item.OLD_EARRING)

    else
        local bonuses        = (player:getMod(xi.mod.SCAVENGE_EFFECT) + player:getMerit(xi.merit.SCAVENGE_EFFECT)) / 100
        local arrowsToReturn = math.floor(math.floor(player:getLocalVar('ArrowsUsed') % 10000) * (player:getMainLvl() / 200 + bonuses))
        local playerID       = target:getID()

        if arrowsToReturn == 0 then
            action:messageID(playerID, 139)
        else
            if arrowsToReturn > 99 then
                arrowsToReturn = 99
            end

            local arrowID = math.floor(player:getLocalVar('ArrowsUsed') / 10000)
            player:addItem(arrowID, arrowsToReturn)

            if arrowsToReturn == 1 then
                action:messageID(playerID, 140)
            else
                action:messageID(playerID, 674)
                action:additionalEffect(playerID, 1)
                action:addEffectParam(playerID, arrowsToReturn)
            end

            player:setLocalVar('ArrowsUsed', 0)
            return arrowID
        end
    end
end

xi.job_utils.ranger.useCamouflage = function(player, target, ability, action)
    local duration = math.random(30, 300) * (1 + 0.01 * player:getMod(xi.mod.CAMOUFLAGE_DURATION))
    player:addStatusEffect(xi.effect.CAMOUFLAGE, 1 , 0, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

xi.job_utils.ranger.useBarrage = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
end

xi.job_utils.ranger.useShadowbind = function(player, target, ability, action)
    if player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP then -- can't have your crossbow/gun held like a bow, now can we?
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local duration      = 30 + player:getMod(xi.mod.SHADOW_BIND_EXT) + player:getJobPointLevel(xi.jp.SHADOWBIND_DURATION)
    local recycleChance = player:getMod(xi.mod.RECYCLE) + player:getMerit(xi.merit.RECYCLE)

    if player:hasStatusEffect(xi.effect.UNLIMITED_SHOT) then
        player:delStatusEffect(xi.effect.UNLIMITED_SHOT)
        recycleChance = 100
    end

    -- TODO: Acc penalty for /RNG, acc vs. mob level?
    if
        math.random(0, 99) >= target:getMod(xi.mod.BIND_MEVA) and
        not target:hasStatusEffect(xi.effect.BIND)
    then
        target:addStatusEffect(xi.effect.BIND, 0, 0, duration)
        ability:setMsg(xi.msg.basic.IS_EFFECT) -- Target is bound.
    else
        ability:setMsg(xi.msg.basic.JA_MISS) -- Player uses Shadowbind, but misses.
    end

    if math.random(0, 99) >= recycleChance then
        player:removeAmmo() -- Shadowbind depletes one round of ammo.
    end

    return xi.effect.BIND
end

xi.job_utils.ranger.useUnlimitedShot = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.UNLIMITED_SHOT, 1, 0, 60)
end

xi.job_utils.ranger.useFlashyShot = function(player, target, ability, action)
    return 0, 0 -- Not implemented yet
end

xi.job_utils.ranger.useStealthShot = function(player, target, ability, action)
    return 0, 0 -- Not implemented yet
end

xi.job_utils.ranger.useDoubleShot = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.DOUBLE_SHOT, 40, 0, 90)
end

xi.job_utils.ranger.useBountyShot = function(player, target, ability, action)
    local mobTHLevel        = target:getTHlevel()
    local bountyShotTHLevel = 2 + player:getMod(xi.mod.BOUNTY_SHOT_TH_BONUS)
    local playerTHLevel     = player:getMod(xi.mod.TREASURE_HUNTER)
    local newTHLevel        = 0

    player:removeAmmo()
    action:speceffect(target:getID(), 0x01) -- functional, animation not correct without this
    ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)

    target:updateClaim(player)

    -- pre-apply up to max value of TH4
    if mobTHLevel < 4 and playerTHLevel > mobTHLevel then
        newTHLevel = math.min(4, playerTHLevel)

        target:setTHlevel(newTHLevel)

        mobTHLevel = newTHLevel
    end

    -- 100% success rate if bounty shot level is higher than their TH level
    if bountyShotTHLevel > mobTHLevel then
        ability:setMsg(xi.msg.basic.JA_TH_EFFECTIVENESS)
        target:setTHlevel(bountyShotTHLevel)

        return bountyShotTHLevel
    end

    -- https://www.bg-wiki.com/ffxi/Bounty_Shot
    -- https://wiki.ffo.jp/html/22203.html
    if mobTHLevel < 12 + player:getMod(xi.mod.TREASURE_HUNTER_CAP) then
        local treausureHunterLevelDiff = mobTHLevel - bountyShotTHLevel

        -- TODO: this rate is the same as THF treasure hunter procs. It is unclear if this has the same rate or better than THF auto attacks.
        -- This also assumes proc rate bonus works on Bounty Shot, but without mountains of data I wouldn't be able to tell.
        -- JP wiki implies these rates and functionality is the same as THF, but there's no data.
        -- BG wiki claims proc rates are similar to SA + TA procs, which seems likely given the 1 min timer on bounty shot.
        local procRate      = 0.10 / math.pow(2, treausureHunterLevelDiff)
        local procRateBonus = 1.0 + (target:getMod(xi.mod.TREASURE_HUNTER_PROC) + player:getMod(xi.mod.TREASURE_HUNTER_PROC)) / 100

        if math.random() < procRate * procRateBonus then
            newTHLevel = mobTHLevel + 1

            ability:setMsg(xi.msg.basic.JA_TH_EFFECTIVENESS)

            target:setTHlevel(newTHLevel)

            return newTHLevel
        end
    end

    -- If we got here, TH was upgraded to 3 or 4 from gear
    -- JP wiki indicates this doesn't happen, but printing incorrectly that the action didn't boost TH level seems weird
    if newTHLevel > 0 then
        ability:setMsg(xi.msg.basic.JA_TH_EFFECTIVENESS)

        return newTHLevel
    end

    return 0
end

xi.job_utils.ranger.useDecoyShot = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.DECOY_SHOT, 11, 1, 30)
end

xi.job_utils.ranger.useHoverShot = function(player, target, ability, action)
    return 0, 0 -- Not implemented yet
end

xi.job_utils.ranger.useOverkill = function(player, target, ability, action)
    player:addStatusEffect(xi.effect.OVERKILL, 11, 1, 60)
end
