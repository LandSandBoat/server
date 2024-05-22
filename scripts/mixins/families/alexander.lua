require('scripts/globals/mixins')

g_mixins = g_mixins or {}

g_mixins.alexander = function(alexanderMob)
    alexanderMob:addListener('ENGAGE', 'ALEXANDER_ENGAGE', function(mob, target)
        local ID = zones[mob:getZoneID()]

        mob:showText(mob, ID.text.SHALL_BE_JUDGED)
    end)

    alexanderMob:addListener('COMBAT_TICK', 'ALEXANDER_COMBAT', function(mob, target)
        if
            mob:getHPP() <= 50 and
            mob:getTP() >= 1000 and
            mob:getLocalVar('DivineJudgment') == 0
        then
            mob:setLocalVar('DivineJudgment', 1)
            mob:useMobAbility(2147)
        end

        local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
        if mob:getHPP() <= 10 and skillList == 784 then
            mob:setMobMod(xi.mobMod.SKILL_LIST, 785)
        end
    end)

    alexanderMob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mob, skillID)
        local ID = zones[mob:getZoneID()]

        -- Radiant Sacrament
        if skillID == 2141 then
            mob:showText(mob, ID.text.OFFER_THY_WORSHIP)
        -- Mega Holy
        elseif skillID == 2142 then
            mob:showText(mob, ID.text.OPEN_THINE_EYES)
        -- Perfect Defense
        elseif skillID == 2143 then
            mob:showText(mob, ID.text.CEASE_THY_STRUGGLES)
        -- Divine Spear
        elseif skillID == 2144 then
            mob:showText(mob, ID.text.RELEASE_THY_SELF)
        -- Gospel of the Lost
        elseif skillID == 2145 then
            mob:showText(mob, ID.text.BASK_IN_MY_GLORY)
        -- Void of Repentance
        elseif skillID == 2146 then
            mob:showText(mob, ID.text.REPENT_THY_IRREVERENCE)

            local instance = mob:getInstance()
            if instance:getID() == 7702 then
                local imageToSpawn = nil
                local imageOne = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_1, instance)
                local imageTwo = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_2, instance)
                local imageThree = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_3, instance)

                if not imageOne:isSpawned() then
                    imageToSpawn = imageOne
                elseif not imageTwo:isSpawned() then
                    imageToSpawn = imageTwo
                elseif not imageThree:isSpawned() then
                    imageToSpawn = imageThree
                end

                if imageToSpawn then
                    imageToSpawn:setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos() + math.random(-2, 2), mob:getZPos() + math.random(-2, 2), mob:getRotPos())
                    imageToSpawn:spawn()

                    local target = mob:getTarget()
                    if target then
                        imageToSpawn:updateEnmity(target)
                    end
                end
            end
        -- Divine Judgment
        elseif skillID == 2147 then
            mob:showText(mob, ID.text.ACCEPT_THY_DESTRUCTION)
            mob:showText(mob, ID.text.OMEGA_SPAM)
        end
    end)

    alexanderMob:addListener('DEATH', 'ALEXANDER_DEATH', function(mob, killer)
        local ID = zones[mob:getZoneID()]

        if not killer then
            return
        else
            mob:showText(mob, ID.text.SHALL_KNOW_OBLIVION)
        end

        local instance = mob:getInstance()
        if instance:getID() == 7702 then
            local imageOne = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_1, instance)
            if imageOne:isSpawned() then
                imageOne:setHP(0)
            end

            local imageTwo = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_2, instance)
            if imageTwo:isSpawned() then
                imageTwo:setHP(0)
            end

            local imageThree = GetMobByID(ID.mob[60].ALEXANDER_IMAGE_3, instance)
            if imageThree:isSpawned() then
                imageThree:setHP(0)
            end
        end
    end)

    alexanderMob:addListener('DESPAWN', 'ALEXANDER_DESPAWN', function(mob)
        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end)
end

return g_mixins.alexander
