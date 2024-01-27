require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.maat = function(maatMob)
    maatMob:addListener('SPAWN', 'JOB_SPECIAL_SPAWN', function(mob)
        if mob:getMainJob() == xi.job.NIN then
            mob:setLocalVar('specialThreshold', 40)
        elseif mob:getMainJob() == xi.job.DRG then
            mob:setLocalVar('specialThreshold', 75)
        else
            mob:setLocalVar('specialThreshold', math.random(50, 60))
        end
    end)

    maatMob:addListener('ROAM_TICK', 'MAAT_RTICK', function(mob)
        if mob:getLocalVar('engaged') == 0 then
            local players = mob:getZone():getPlayers()
            for _, player in pairs(players) do
                if player:checkDistance(mob) < 8 then
                    local ID = zones[mob:getZoneID()]
                    mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
                    mob:setLocalVar('engaged', player:getID())
                end
            end
        end
    end)

    maatMob:addListener('ENGAGE', 'MAAT_ENGAGE', function(mob, target)
        if mob:getLocalVar('engaged') == 0 then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP)
            mob:setLocalVar('engaged', target:getID())
        end
    end)

    maatMob:addListener('DISENGAGE', 'MAAT_DISENGAGE', function(mob)
        local engagedID = mob:getLocalVar('engaged')
        if engagedID ~= 0 then
            local player = GetPlayerByID(engagedID)
            if player:getHP() == 0 then
                local ID = zones[mob:getZoneID()]
                mob:showText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
            end
        end
    end)

    maatMob:addListener('COMBAT_TICK', 'MAAT_CTICK', function(mob)
        local defaultAbility =
        {
            [xi.job.WAR] = xi.jsa.MIGHTY_STRIKES_MAAT,
            [xi.job.MNK] = xi.jsa.HUNDRED_FISTS_MAAT,
            [xi.job.WHM] = xi.jsa.BENEDICTION_MAAT,
            [xi.job.BLM] = xi.jsa.MANAFONT_MAAT,
            [xi.job.RDM] = xi.jsa.CHAINSPELL_MAAT,
            [xi.job.THF] = xi.jsa.PERFECT_DODGE_MAAT,
            [xi.job.PLD] = xi.jsa.INVINCIBLE_MAAT,
            [xi.job.DRK] = xi.jsa.BLOOD_WEAPON_MAAT,
            [xi.job.BST] = xi.jsa.FAMILIAR_MAAT,
            [xi.job.BRD] = xi.jsa.SOUL_VOICE_MAAT,
            [xi.job.RNG] = xi.jsa.EES_MAAT,
            [xi.job.SAM] = xi.jsa.MEIKYO_SHISUI_MAAT,
            [xi.job.NIN] = xi.jsa.MIJIN_GAKURE_MAAT,
            [xi.job.DRG] = xi.jsa.CALL_WYVERN_MAAT,
            [xi.job.SMN] = xi.jsa.ASTRAL_FLOW_MAAT,
        }

        if mob:getHPP() < mob:getLocalVar('specialThreshold') then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.NOW_THAT_IM_WARMED_UP)
            mob:useMobAbility(defaultAbility[mob:getMainJob()])
            mob:setLocalVar('specialThreshold', 0)
        end

        if
            mob:getHPP() < 20 or
            (mob:getMainJob() == xi.job.WHM and mob:getBattleTime() > 300)
        then
            local ID = zones[mob:getZoneID()]
            mob:showText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
            mob:getBattlefield():win()
        end
    end)

    maatMob:addListener('ITEM_STOLEN', 'MAAT_ITEM_STOLEN', function(mob, player, itemId)
        if mob:getMainJob() == xi.job.THF then
            local ID = zones[mob:getZoneID()]
            mob:messageText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
            mob:getBattlefield():win()
        end
    end)

    maatMob:addListener('DEATH', 'MAAT_DEATH', function(mob, killer)
        local ID = zones[mob:getZoneID()]
        mob:messageText(mob, ID.text.YOUVE_COME_A_LONG_WAY)
    end)

    maatMob:addListener('WEAPONSKILL_TAKE', 'MAAT_WEAPONSKILL_TAKE', function(target, user, wsid, tp, action)
        local ID = zones[target:getZoneID()]
        target:messageText(target, ID.text.THAT_LL_HURT_IN_THE_MORNING)
    end)

    maatMob:addListener('WEAPONSKILL_USE', 'MAAT_WEAPONSKILL_USE', function(mob, target, wsid, tp, action)
        local ID = zones[mob:getZoneID()]
        if wsid == 1028 then -- Tackle
            mob:messageText(mob, ID.text.TAKE_THAT_YOU_WHIPPERSNAPPER)
        elseif wsid == 1033 then -- Dragon Kick
            mob:messageText(mob, ID.text.TEACH_YOU_TO_RESPECT_ELDERS)
        elseif wsid == 1034 then -- Asuran Fists
            mob:messageText(mob, ID.text.LOOKS_LIKE_YOU_WERENT_READY)
        end
    end)
end

return g_mixins.maat
