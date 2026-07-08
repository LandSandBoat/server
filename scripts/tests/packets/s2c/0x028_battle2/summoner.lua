local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Garuda Predator Claws sequence'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.SMN)
            player:spawnPet(xi.petId.GARUDA)
            player.actions:useAbility(mob, xi.jobAbility.PREDATOR_CLAWS)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_MOB,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.PREDATOR_CLAWS,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.PET_MOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.PREDATOR_CLAWS,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_MOB,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 3,
                                sub_kind  = 86,
                                info      = ph.IGNORE,
                                scale     = ph.IGNORE,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.USES_JA_TAKE_DAMAGE,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
    ['Garuda Hastega sequence'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.SMN)
            player:spawnPet(xi.petId.GARUDA)
            player.actions:useAbility(player, xi.jobAbility.HASTEGA)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.HASTEGA,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 2,
                                sub_kind  = 94,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.HASTEGA,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 2,
                res_sum = 0,
                cmd_no  = xi.action.category.PET_MOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.HASTEGA,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 3,
                                sub_kind  = 83,
                                info      = 0,
                                scale     = 0,
                                value     = xi.effect.HASTE,
                                message   = xi.msg.basic.SKILL_GAIN_EFFECT_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 3,
                                sub_kind  = 83,
                                info      = 0,
                                scale     = 0,
                                value     = xi.effect.HASTE,
                                message   = xi.msg.basic.JA_GAIN_EFFECT,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },

    ['Blood Pact: Rage (Too Far Away)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.SMN)
            player:spawnPet(xi.petId.GARUDA)
            player.actions:useAbility(mob, xi.jobAbility.PREDATOR_CLAWS)
            xi.test.world:tickEntity(player)
            mob:setPos(0, 0, 0)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_FINISH,
                cmd_arg = 0,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_MOB,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.PREDATOR_CLAWS,
                                message   = xi.msg.basic.TOO_FAR_AWAY_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
    ['Blood Pact: Ward (Too Far Away)'] =
    {
        test = function(player, mob)
            player:changeJob(xi.job.SMN)
            player:spawnPet(xi.petId.CARBUNCLE)

            local player2 = xi.test.world:spawnPlayer({ zone = player:getZoneID() })
            player.actions:inviteToParty(player2)
            player2.actions:acceptPartyInvite()
            player2.actions:move(player:getXPos(), player:getYPos(), player:getZPos())

            -- Use Healing Ruby on the player2
            player.actions:useAbility(player2, xi.jobAbility.HEALING_RUBY)
            xi.test.world:tickEntity(player)
            player2.actions:move(100, 0, 100)
            xi.test.world:skipTime(10)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.HEALING_RUBY,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 2,
                                sub_kind  = 94,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.HEALING_RUBY,
                                message   = xi.msg.basic.READIES_SKILL_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MAGIC_FINISH,
                cmd_arg = 0,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = xi.jobAbility.HEALING_RUBY,
                                message   = xi.msg.basic.TOO_FAR_AWAY_2,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_INTERRUPT,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 508,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
}

return packets
