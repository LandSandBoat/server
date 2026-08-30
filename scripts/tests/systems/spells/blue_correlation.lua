describe('Blue Magic monster correlation', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    -- Correlation is +/-0.25 on the spell's multiplier, not a multiplier on the final damage
    -- FF11用語辞典 - https://wiki.ffo.jp/html/5472.html
    --   「優劣によって、各魔法のダメージ倍率に±0.25の補正が入る。最終ダメージに直接25%乗算される訳では無い。」
    -- BG-wiki - https://www.bg-wiki.com/ffxi/Calculating_Blue_Magic_Damage
    --   "the multiplier value is raised by 0.25"
    --
    -- ecosystemMultiplier() hands back 1.0 for a neutral matchup, so it has to be
    -- turned into a bonus before it's added to anything. Added raw, every spell
    -- picks up a flat +1.0.
    -- Foot Kick from a naked Hume BLU99 (STR 72 with the captured base stat formula) against a level 28 Clipper
    local neutralDamage      = 30
    local favourableDamage   = 37 -- 1.00 -> 1.25
    local unfavourableDamage = 22 -- 1.00 -> 0.75

    before_each(function()
        xi.test.world:setSeed(1)

        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.BLU,
                level = 99,
                zone  = xi.zone.QUFIM_ISLAND,
            })

        player:setSkillLevel(xi.skill.BLUE_MAGIC, 424)
        player:addSpell(xi.magic.spell.FOOT_KICK)
        player.actions:setBlueSpells({ xi.magic.spell.FOOT_KICK })

        -- The Clipper spawns at level 28 or 29, so its VIT, its DEF, and the damage below all
        -- depend on the shared RNG stream. Pin the level.
        mob = player.entities:moveTo(17293357)
        mob:setLevelRange(28, 28)
        mob:respawn()
        mob.assert:isAlive()
    end)

    local function castFootKick(ecosystemMultiplier)
        stub('math.randomInt', function(low, _)
            return low
        end)

        stub('math.randomFloat', function(_, high)
            return high
        end)

        stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
        stub('xi.combat.damage.ecosystemMultiplier', ecosystemMultiplier)

        player:resetRecasts()
        player:setMP(player:getMaxMP())

        mob:setMaxHP(50000)
        mob:setHP(50000)
        mob:updateClaim(player)

        local before = mob:getHP()
        player.actions:useSpell(mob, xi.magic.spell.FOOT_KICK)
        xi.test.world:skipTime(10)

        return before - mob:getHP()
    end

    it('leaves the multiplier alone on a neutral matchup', function()
        local damage = castFootKick(1.0)

        assert(damage == neutralDamage, string.format('Expected %d, got %d (near %d means the multiplier is being added raw)', neutralDamage, damage, neutralDamage * 2))
    end)

    it('adds 0.25 to the multiplier on a favourable matchup', function()
        local damage = castFootKick(1.25)

        assert(damage == favourableDamage, string.format('Expected %d, got %d', favourableDamage, damage))
    end)

    it('subtracts 0.25 from the multiplier on an unfavourable matchup', function()
        local damage = castFootKick(0.75)

        assert(damage == unfavourableDamage, string.format('Expected %d, got %d', unfavourableDamage, damage))
    end)
end)
