-----------------------------------
-- メイン設定
-----------------------------------
-- 全ての設定は `xi.settings` オブジェクトに紐付けられています。これはグローバルに公開され、C++とあらゆるスクリプトからアクセスできます。
--
-- このファイルは主にコンテンツ、バランス、およびゲームプレイの調整に関するものです。
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.main =
{
    -- サーバー名 (15文字以内)
    SERVER_NAME = "Nameless",

    SERVER_MESSAGE =
        "Please visit https://github.com/LandSandBoat/server for the latest information on the project.\n" ..
        "Thank you, and we hope you enjoy sailing the sands!",

    -- 下記で定義された拡張コンテンツをより正確にロックするための設定。
    -- これにより、選択した拡張コンテンツがより正確に表現され、
    -- 無効になっているもの（ロードされていないもの）に関してプレイヤーが混乱することが少なくなります。
    -- この機能は、SQLファイルの content_tag 列に対応しています。
    RESTRICT_CONTENT = 0,

    -- 拡張コンテンツを有効にする (1 = 有効, 0 = 無効)
    ENABLE_COP       = 1,  -- プロマシアの呪縛
    ENABLE_TOAU      = 1,  -- アトルガンの秘宝
    ENABLE_WOTG      = 1,  -- アルタナの神兵
    ENABLE_ACP       = 1,  -- 追加シナリオ「石を見る夢」
    ENABLE_AMK       = 1,  -- 追加シナリオ「戦慄！モグ祭りの夜」
    ENABLE_ASA       = 1,  -- 追加シナリオ「シャントット帝国の陰謀」
    ENABLE_ABYSSEA   = 1,  -- アビセア
    ENABLE_SOA       = 1,  -- アドゥリンの魔境
    ENABLE_ROV       = 1,  -- 星唄ミッション
    ENABLE_TVR       = 1,  -- 触世のエンブリオ
    ENABLE_VOIDWATCH = 1,  -- 拡張コンテンツではありませんが、独自のストーリーがあります。(未実装)

    -- フィールド・オブ・ヴァラー/グラウンド・オブ・ヴァラー設定
    ENABLE_FIELD_MANUALS  = 1, -- フィールド・オブ・ヴァラーを有効にする
    ENABLE_GROUNDS_TOMES  = 1, -- グラウンド・オブ・ヴァラーを有効にする
    ENABLE_SURVIVAL_GUIDE = 1, -- サバイバルガイドを有効にする (未実装)
    REGIME_WAIT           = 1, -- 公式と同様に、ゲーム内時間0:00まで待機させる。0の場合は待機時間なし。
    FOV_REWARD_ALLIANCE   = 0, -- アライアンスに所属している間もフィールド・オブ・ヴァラーを許可する。(公式のデフォルト動作: 0)
    GOV_REWARD_ALLIANCE   = 1, -- アライアンスに所属している間もグラウンド・オブ・ヴァラーを許可する。(公式のデフォルト動作: 1)

    -- デイリーポイント / ゴブリンの不思議箱
    ENABLE_DAILY_TALLY = 1,  -- ゴブリンの不思議箱のデイリーポイント取得を許可する。
    DAILY_TALLY_AMOUNT = 10, -- 1日あたりに取得できるデイリーポイント数
    DAILY_TALLY_LIMIT  = 50000, -- デイリーポイントの上限
    GOBBIE_BOX_MIN_AGE = 45, -- ゴブリンの不思議箱に登録できるようになるまでのキャラクター作成日数の下限

    -- エミネンスレコード
    ENABLE_ROE            = 1, -- エミネンスレコードを有効にする
    ENABLE_ROE_TIMED      = 1, -- 4時間制のレコードを有効にする
    ENABLE_EXCHANGE_LIMIT = 1, -- 1週間あたりの功績ポイント/ワークスポイントの使用上限を有効にする (リテール版のデフォルト動作: 1)

    WEEKLY_EXCHANGE_LIMIT = 100000, -- 1週間あたりに使用できる功績ポイント/ワークスポイントの上限 (リテール版のデフォルト値: 100000)

    -- 通貨上限 (変更は自己責任で！)
    CAP_CURRENCY_ACCOLADES = 99999, -- ワークスポイントの上限
    CAP_CURRENCY_BALLISTA  = 2000,  -- バリスタポイントの上限
    CAP_CURRENCY_SPARKS    = 99999, -- エミネンスポイントの上限
    CAP_CURRENCY_VALOR     = 50000, -- ベイラーポイントの上限

    -- メイジャンの試練
    ENABLE_MAGIAN_TRIALS = 1,

    -- ボイドウォーカー
    ENABLE_VOIDWALKER = 1,

    -- モブリンメンズモンガー
    ENABLE_MMM = 0,

    -- モンストロス・プレッジ (開発中のため、使用は自己責任で！)
    ENABLE_MONSTROSITY               = 0,   -- モンストロス・プレッジを有効にする
    MONSTROSITY_INFAMY_RATIO         = 0.1, -- (float) モンスターを倒したときに得られる経験値と悪名の比率。
    MONSTROSITY_INFAMY_MESSAGING     = 0,   -- 悪名を得たときにメッセージを表示する。
    MONSTROSITY_TELEPORT_TO_FERETORY = 0,   -- 変身解除または死亡時に、フェレトリーに入ったゾーンではなく、フェレトリーに戻る。
    MONSTROSITY_TRIGGER_NPCS         = 0,   -- モニピュレーターがフェレトリーの外のNPCをトリガーすることを許可する。
    MONSTROSITY_DONT_WIPE_BUFFS      = 0,   -- 設定されている場合、フェレトリーで種族を変更してもバフは消去されない。

    -- モンストロス・プレッジPvPモード
    -- 0: リテール版 (完全制限): モニピュレーターとプレイヤーは戦闘前に互いに戦闘態勢を取る必要がある
    -- 1: (部分制限): プレイヤーは戦闘態勢を取る必要がないが、モニピュレーターは必要。
    -- 2: (オープン): プレイヤーとモニピュレーターは戦闘態勢を取る必要がない。
    MONSTROSITY_PVP_MODE        = 0,
    MONSTROSITY_PVP_ZONE_BYPASS = 0, -- 戦闘態勢中にフェレトリーから完全なゾーンテレポメニューを表示する。

    -- トレジャーキャスケット
    -- リテール版のドロップ率 = 0.1 (10%)、他の効果はなし
    -- 0に設定するとカスクは無効になります。
    -- 最大値は1.0 (100%)に制限されています。
    CASKET_DROP_RATE = 0.1,
    -- パスワードなしでトレジャーキャスケットを開くことを許可する
    CASKET_NO_PASSWORD = false,
    -- 茶箱の確率（最大値は1.0)残りの率が青箱
    CASKET_BROWN_CHANCE = 0.2,

    -- アビセアの光
    -- 光の量に応じてドロップ率が自動的に低下する特定のモンスターがいます。
    -- 真珠の光はドロップ率が劇的に低くなります。
    -- 最小値は0、最大値は100 (1 = 1%)
    ABYSSEA_LIGHTS_DROP_RATE = 80,

    -- アビセアに入場したプレイヤーの光に追加されるボーナス。主にイベント中に使用されます。
    -- 推奨値は0～100。一部の光は255で上限に達しますが、それ以外の光はもっと低い値で上限に達します。上限は自動的に適用されます。
    ABYSSEA_BONUSLIGHT_AMOUNT = 0,

    -- キャラクター設定
    INITIAL_LEVEL_CAP              = 50, -- 新規プレイヤーの初期レベルキャップ。255のハードキャップがあるようです。
    MAX_LEVEL                      = 99, -- サーバーの最大レベル。限界突破クエストを無効にすることで到達可能な上限を下げます。
    NORMAL_MOB_MAX_LEVEL_RANGE_MIN = 0,  -- 通常モンスターの最大レベル範囲の下限 (0 = 無制限)
    NORMAL_MOB_MAX_LEVEL_RANGE_MAX = 0,  -- 通常モンスターの最大レベル範囲の上限 (0 = 無制限)
    START_GIL                      = 10, -- 新規作成キャラクターに与えられるギル量。
    START_INVENTORY                = 30, -- 開始時の所持品とサッチェルのサイズ。30未満の値は無視されます。80以上に設定しないでください！
    NEW_CHARACTER_CUTSCENE         = 1,  -- 1に設定するとオープニングカットシーンが有効になり、0に設定すると無効になります。
    SUBJOB_QUEST_LEVEL             = 18, -- サブジョブクエストを受注できる最低レベル。0に設定すると、ゲーム開始時にサブジョブがアンロックされます。
    ADVANCED_JOB_LEVEL             = 30, -- 上位ジョブクエストを受注できる最低レベル。0に設定すると、ゲーム開始時に上位ジョブがアンロックされます。
    ALL_MAPS                       = 0,  -- 1に設定すると、開始キャラクターにすべてのマップが与えられます。
    UNLOCK_OUTPOST_WARPS           = 0,  -- 1に設定すると、開始キャラクターにすべての拠点ワープが与えられます。2に設定すると、Tu'LiaとTavnaziaが追加されます。

    SHOP_PRICE      = 1.000, -- NPCショップの価格に倍率をかける。
    GIL_RATE        = 1.000, -- クエストから得られるギルに倍率をかける。ゲーム内では常に表示されるとは限りません。
    BAYLD_RATE      = 1.000, -- クエストから得られるベイldに倍率をかける。
    -- 注：経験値レートはconf設定の影響も受けます。
    EXP_RATE        = 1.000, -- スクリプトからの経験値に倍率をかける (勲章/練武訓練場を除く)。
    CAPACITY_RATE   = 1.000, -- キャパシティポイントの獲得量に倍率をかける。
    BOOK_EXP_RATE   = 1.000, -- 勲章/練武訓練場のブックページからの経験値に倍率をかける。
    TABS_RATE       = 1.000, -- 勲章で得られるタブに倍率をかける。
    ROE_EXP_RATE    = 1.000, -- レコード・オブ・エミネンスで得られる経験値に倍率をかける。
    SPARKS_RATE     = 1.000, -- レコード・オブ・エミネンスで得られる功績ポイントに倍率をかける。
    CURE_POWER      = 1.000, -- 回復魔法（関連する青魔法を含む）の回復量に倍率をかける。
    ELEMENTAL_POWER = 1.000, -- 精霊魔法と吸収のない暗黒魔法のダメージに倍率をかける。
    DIVINE_POWER    = 1.000, -- 神聖魔法のダメージに倍率をかける。
    NINJUTSU_POWER  = 1.000, -- 忍術のダメージに倍率をかける。
    BLUE_POWER      = 1.000, -- 青魔法のダメージに倍率をかける。
    DARK_POWER      = 1.000, -- 暗黒魔法の吸収量に倍率をかける。
    ITEM_POWER      = 1.000, -- ポーションやエーテルなどのアイテムの効果に倍率をかける。
    WEAPON_SKILL_POWER  = 1.000, -- ウェポンスキルのダメージに倍率をかける。

    USE_ADOULIN_WEAPON_SKILL_CHANGES = true,  -- true/false。アドゥリンの新しいウェポンスキルダメージ計算を切り替えます。
    DISABLE_PARTY_EXP_PENALTY        = false, -- true/false。パーティ経験値ペナルティを無効にするかどうか。
    ENABLE_IMMUNOBREAK               = true,  -- true/false。耐性突破を許可/禁止する。
    USE_PRE_2013_DEX_MULTIPLIER      = false, -- true/false. False uses 75% of DEX for accuracy calculation. Prior to 2013 50% of DEX was used.
    USE_PRE_2013_STR_MULTIPLIER      = false, -- true/false. False uses STR multiplier of 1.0 for two handed, one handed main, and ranged attacks, 0.75 for H2H, and 0.5 for one handed in sub slot. True uses 0.5 of STR across the board and is how the game was from release to mid 2013.

    -- フェイス
    ENABLE_TRUST_CASTING           = 1, -- フェイスの魔法詠唱を許可する
    ENABLE_TRUST_QUESTS            = 1, -- フェイス関連クエストを有効にする
    ENABLE_TRUST_CUSTOM_ENGAGEMENT = 0, -- フェイスのカスタム戦闘開始条件を有効にする

    ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA          = 0, -- 0 = 無効, 1 = 夏/新年, 2 = 春/秋, 3 = 両方
    ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA_ANNOUNCE = 0, -- 0 = 無効, 1 = プレイヤーログイン時にアナウンスを追加
    ENABLE_TRUST_ALTER_EGO_EXPO                  = 0, -- 0 = 無効, 1 = 通常エキスポ - HP/MP/状態異常耐性向上, 2 = 特別エキスポ (未実装)
    ENABLE_TRUST_ALTER_EGO_EXPO_ANNOUNCE         = 0, -- 0 = 無効, 1 = プレイヤーログイン時にアナウンスを追加

    TRUST_ALTER_EGO_EXTRAVAGANZA_MESSAGE =
        "\n \n" .. -- The space between these newlines is intentional
        "\129\153\129\154 The Alter Ego Extravaganza Campaign is active! \129\154\129\153\n" ..
        "This is an excellent time to fill out your roster of Trusts!",

    TRUST_ALTER_EGO_EXPO_MESSAGE =
        "\n \n" .. -- The space between these newlines is intentional
        "\129\153\129\154 The Alter Ego Expo Campaign is active! \129\154\129\153\n" ..
        "Trusts gain the benefits of Increased HP, MP, and Status Resistances!",

    HARVESTING_BREAK_CHANCE = 33, -- 収穫中に草刈鎌が壊れる確率(%)。0～100の値を設定します。
    EXCAVATION_BREAK_CHANCE = 33, -- 採掘中につるはしが壊れる確率(%)。0～100の値を設定します。
    LOGGING_BREAK_CHANCE    = 33, -- 伐採中にまさかりが壊れる確率(%)。0～100の値を設定します。
    MINING_BREAK_CHANCE     = 33, -- 鉱石採掘中につるはしが壊れる確率(%)。0～100の値を設定します。
    HARVESTING_RATE         = 50, -- 収穫でアイテムを入手できる確率(%)。0～100の値を設定します。
    EXCAVATION_RATE         = 50, -- 採掘でアイテムを入手できる確率(%)。0～100の値を設定します。
    LOGGING_RATE            = 50, -- 伐採でアイテムを入手できる確率(%)。0～100の値を設定します。
    MINING_RATE             = 50, -- 鉱石採掘でアイテムを入手できる確率(%)。0～100の値を設定します。
    DIGGING_RATE            = 85, -- 好ましい天候時にチョコボ掘りでアイテムを入手できる確率(%)。0～100の値を設定します。

    HEALING_TP_CHANGE       = -100, -- 回復ティックごとのTPの変化量。デフォルトは-100です。

    -- SEは、宝箱/木箱の採取を防止するために、宝箱/木箱のイリュージョン時間を実装しました。同じエリアにいる誰もが、MIN_ILLSION_TIMEとMAX_ILLUSION_TIMEの間のランダムな時間まで、宝箱または木箱からアイテム（ギル、宝石、アイテム）を略奪できません。
    -- この間、プレイヤーはクエストに関連するキーアイテムとアイテム（アーティファクト、マップなど）を略奪できます。
    COFFER_MAX_ILLUSION_TIME = 3600,  -- 1時間 (宝箱)
    COFFER_MIN_ILLUSION_TIME = 1800,  -- 30分 (宝箱)
    CHEST_MAX_ILLUSION_TIME  = 3600,  -- 1時間 (木箱)
    CHEST_MIN_ILLUSION_TIME  = 1800,  -- 30分 (木箱)


    -- NM抽選ポップの発生確率に対する倍率。(デフォルト1.0) 例：0 = 抽選ポップを無効にする。-1 = 常に100%の確率。
    NM_LOTTERY_CHANCE = 1.0,
    -- NM抽選クールダウン時間に対する倍率。(デフォルト1.0) 例：2.0 = 2倍の長さ。0 = クールダウンなし。
    NM_LOTTERY_COOLDOWN = 1.0,

    -- 拠点戦設定
    ENABLE_GARRISON        = true,  -- trueの場合、拠点戦機能を有効にします。
    GARRISON_LOCKOUT       = 1800,  -- 新しい拠点戦を開始できるまでの時間（秒）（デフォルト：1800）
    GARRISON_TIME_LIMIT    = 1800,  -- 拠点戦が失敗するまでの制限時間（秒）（デフォルト：1800）
    GARRISON_ONCE_PER_WEEK = true,  -- falseに設定すると、征服集計週あたりの拠点戦1回制限をバイパスします。
    GARRISON_PARTY_LIMIT   = 18,    -- 拠点戦に参加できる最大パーティメンバー数に設定します（デフォルト：18）。
    GARRISON_NATION_BYPASS = false, -- trueに設定すると、所属国要件をバイパスします。
    GARRISON_RANK          = 2,     -- 拠点戦を開始するための最低所属国ランクに設定します（デフォルト：2）。

    -- デュナミス設定
    BETWEEN_2DYNA_WAIT_TIME     = 24,       -- プレイヤーがデュナミスに再入場できるまでの時間（時間）。デフォルトは1地球日（24時間）。
    DYNA_MIDNIGHT_RESET         = true,     -- trueの場合、待機時間は24時間間隔ではなく、サーバーの深夜の数でカウントされます。
    DYNA_LEVEL_MIN              = 65,       -- デュナミスに入場するための最低レベル。
    TIMELESS_HOURGLASS_COST     = 500000,   -- デュナミスの永遠の砂時計の払い戻し額。
    PRISMATIC_HOURGLASS_COST    = 50000,    -- デュナミスの七色の砂時計のコスト。
    CURRENCY_EXCHANGE_RATE      = 100,      -- X枚のTier 1古代通貨 -> 1枚のTier 2、以下同様。特定の値はショップアイテムと競合する可能性があります。198を超えないように設計されています。
    ENABLE_EXCHANGE_100S_TO_1S  = false,    -- true/false。1万枚を100枚に交換できるように、100枚を1枚に交換することを許可します。
    RELIC_2ND_UPGRADE_WAIT_TIME = 7200,     -- レリックの2回目の強化（ステージ2 -> ステージ3）の待機時間（秒）。7200秒 = 2時間。
    RELIC_3RD_UPGRADE_WAIT_TIME = 3600,     -- レリックの3回目の強化（ステージ3 -> ステージ4）の待機時間（秒）。3600秒 = 1時間。
    FREE_COP_DYNAMIS            = 0,        -- ジラートミッションを完了せずにCOPダイナミスへの入場を許可する（1 = 有効、0 = 無効）。

    -- リンバス設定
    COSMO_CLEANSE_BASE_COST     = 15000,    -- Sagheeraからのコスモクリーンズの基本ギルコスト。

    -- クエスト/ミッション固有の設定
    AF1_QUEST_LEVEL = 40,    -- AF1クエストを開始するための最低レベル。
    AF2_QUEST_LEVEL = 50,    -- AF2クエストを開始するための最低レベル。
    AF3_QUEST_LEVEL = 50,    -- AF3クエストを開始するための最低レベル。
    OLDSCHOOL_G1    = false, -- trueに設定すると、キーアイテム方式ではなく、エクソレイモールド、ボムドコール、古代パピルスのドロップ集めが必要になります。
    OLDSCHOOL_G2    = false, -- trueに設定すると、「最高峰に挑みし者」のNMを倒すことでKIを入手する必要があります（SEが変更する前の仕様）。
    FRIGICITE_TIME  = 30,    -- OLDSCHOOL_G2が有効な場合、これはボレアNMを倒してから「??？」ターゲットをクリックできるまでの時間（秒）です。
    ASSAULT_MINIMUM = 1,     -- アサルトミッションを開始するために必要な最低人数。TOAU時代は3、デフォルトは1です。

    -- 魔法固有の設定
    DIA_OVERWRITE                   = 1,     -- 1に設定すると、バイオが同じ段階のディアを上書きできます。デフォルトは1です。
    BIO_OVERWRITE                   = 0,     -- 1に設定すると、ディアが同じ段階のバイオを上書きできます。デフォルトは0です。
    STONESKIN_CAP                   = 350,   -- ストンスキンで吸収されるHPのソフトキャップ。
    BLINK_SHADOWS                   = 2,     -- ブリンク呪文によって提供される影の数。
    SPIKE_EFFECT_DURATION           = 180,   -- 赤魔道士、黒魔道士のスパイク効果の持続時間（報復を除く）。
    ELEMENTAL_DEBUFF_DURATION       = 120,   -- 属性弱体魔法の基本持続時間。
    AQUAVEIL_COUNTER                = 1,     -- アクアベールが呪文詠唱の中断を防ぐために吸収するヒット数。リテール版は1です。
    SNEAK_INVIS_DURATION_MULTIPLIER = 1,     -- スニーク、インビジ、デオダライズの持続時間に倍率をかけ、プレイヤーの苦痛を軽減します。1 = リテール版の動作。
    USE_OLD_CURE_FORMULA            = false, -- true/false。trueの場合、古いケアルの計算式を使用します (3*MND + VIT + 3*(回復魔法スキル/5)) // ケアルVIは新しい計算式を使用します。
    USE_OLD_MAGIC_DAMAGE            = false, -- true/false。trueの場合、古い魔法ダメージ計算式を使用します。

    -- 季節イベント
    EXPLORER_MOOGLE_LV              = 10, -- 探検モーグリのテレポを有効にし、必要なレベルを設定します。ゼロに設定すると無効になります。
    HALLOWEEN_2005                  = 0,  -- 1に設定すると、2005年版の収穫祭が有効になり、10月20日から11月1日まで開催されます。
    HALLOWEEN_YEAR_ROUND            = 0,  -- 1に設定すると、収穫祭が通常の期間外でも開始されます。
    EGG_HUNT                        = -- エッグハント
    {
        START                       = { DAY = 6,  MONTH = 4 }, -- 開始日
        FINISH                      = { DAY = 17, MONTH = 4 }, -- 終了日

        -- デフォルト時代は2005年
        ERA_2006 = false, -- オーフィックエッグ
        ERA_2007 = false, -- ジュエルドエッグとエッグヘルム
        ERA_2008 = false, -- Tier 2の国別エッグ、ゆで卵の交換を許可
        ERA_2009 = false, -- エッグビュッフェセット
        -- 2009年、2010年、2011年、2012年は同じです
        ERA_2013 = false, -- プリンセグスタータ
        ERA_2014 = false, -- ハッチリングシールド、コプスキャンディ、クラッカー
        ERA_2015 = false, -- ラビットキャップ、ラビットキャップをかぶったNPCを表示
        ERA_2018 = false, -- Sairui-Ran x99とインペリアルエッグのトレードを許可
        ERA_2019 = false, -- Apkallu Eggのトレードを許可

        -- プレイヤーがすでに該当の報酬を受け取っている場合の、
        -- 組み合わせの繰り返しに対する残念賞
        MINOR_REWARDS = true,

        -- カスタムの組み合わせを設定します。例：WORD = 12345
        -- WORDは文字付きエッグの配列です
        -- 12345は報酬のアイテムIDです。
        BONUS_WORDS =
        {
            -- WORD = 12345,
        },
    },

    -- ログインキャンペーン (ログインキャンペーンを実行したくない場合は0に設定)
    -- 正しいキャンペーン日付を割り当てるには、scripts/globals/events/login_campaign.luaを参照してください.
    ENABLE_LOGIN_CAMPAIGN = 0,

    -- 釣りランキングコンテスト
    -- falseに設定すると、コンテストの手動進行が必要になります。
    AUTO_FISHING_CONTEST = true, -- 自動進行
    MAX_FAKE_ENTRIES     = 15,  -- 架空のエントリーの最大数

    -- ナイズル島踏査指令
    RUNIC_DISK_SAVE      = true, -- ナイズル島踏査指令に参加している全員が進行状況を保存できるようにします。falseに設定すると、開始者のみが進行状況を保存できます。
    ENABLE_NYZUL_CASKETS = true, -- NMからのトレジャーカスクのポップを有効にします。
    ENABLE_VIGIL_DROPS   = true, -- NMからの守りの武器のドロップを有効にします。
    ACTIVATE_LAMP_TIME   = 6000, -- ランプが点灯している時間（ミリ秒）。TODO: リテール版での確認が必要です。

    -- チョコボ育成 (開発中のため、使用は自己責任で！)
    -- GMコマンド: `!chocoboraising`
    ENABLE_CHOCOBO_RAISING              = false, -- true/false。チョコボ育成機能を有効にします。
    DEBUG_CHOCOBO_RAISING               = false, -- true/false。チョコボ育成の詳細なデバッグログを有効にします（プレイヤーに見えます）。
    CHOCOBO_RAISING_STAT_POS_MULTIPLIER = 1.0,   -- float。正のステータス変化の倍率。デフォルトは1.0です。
    CHOCOBO_RAISING_STAT_NEG_MULTIPLIER = 1.0,   -- float。負のステータス変化の倍率。デフォルトは1.0です。
    CHOCOBO_RAISING_GIL_MULTIPLIER      = 1.0,   -- float。チョコボのアクション（ケアプランなど）で得られるギルの倍率。デフォルトは1.0です。
    CHOCOBO_RAISING_DISABLE_RETIREMENT  = false, -- true/false。引退を無効にするかどうか。
    CHOCOBO_RAISING_STAT_GROWTH_CAP     = 512,   -- int。ステータス成長の上限。

    -- 錬成 (開発中のため、使用は自己責任で！)
    ENABLE_SYNERGY = false, -- true/false。錬成機能を有効にします。

    -- その他
    RIVERNE_PORTERS              = 120,   -- リヴェーヌ岩塊群の不安定な転移が、鱗をトレードした後、開いたままになる時間（秒）。
    LANTERNS_STAY_LIT            = 1200,  -- 怨念洞のランタンが点灯している時間（秒）。
    ENABLE_COP_ZONE_CAP          = 0,     -- プロマシアの幻影エリアでレベルキャップを有効または無効にする。
    ALLOW_MULTIPLE_EXP_RINGS     = 0,     -- 1に設定すると、チャリオットバンド/エンプレスバンド/エンペラーバンドトリオの所有権制限が解除されます。
    BYPASS_EXP_RING_ONE_PER_WEEK = 0,     -- 1に設定すると、コンクエストあたりの指輪1個制限を解除します。
    NUMBER_OF_DM_EARRINGS        = 1,     -- プレイヤーが同時に所有できる神威の耳飾りの数（デフォルト：1）。
    HOMEPOINT_TELEPORT           = 1,     -- ホームポイントテレポシステムを有効にします。
    DIG_ABUNDANCE_BONUS          = 0,     -- アイテムを掘り出す確率を上げます（450 = アイテム掘り出し確率+45）。
    DIG_FATIGUE                  = 100,   -- 1日に許可される掘削成功回数。0に設定すると、掘削疲労を無効にします。
    DIG_GRANT_BURROW             = 0,     -- 1に設定すると、チョコボの「穴掘り」アビリティが付与されます。
    DIG_GRANT_BORE               = 0,     -- 1に設定すると、チョコボの「宝探し」アビリティが付与されます。
    ENM_COOLDOWN                 = 120,   -- プレイヤーがENMの同じキーアイテムを再取得できるまでの時間（時間）（デフォルト：5日=120時間）。
    FORCE_SPAWN_QM_RESET_TIME    = 300,   -- 強制ポップするモンスターが消滅した後、「??？」が隠されたままになる時間（秒）。
    EQUIP_FROM_OTHER_CONTAINERS  = false, -- true/false。モグサッチェル、サック、ケースからのアイテムの装備を許可します。クライアントアドオンを使用した場合にのみ可能です。
    REGIME_REWARD_THRESHOLD      = 15,    -- プレイヤーが推奨レベル範囲の最低レベルよりNレベル以上低い場合、経験値は付与されません。

    -- システム
    DISABLE_INACTIVITY_WATCHDOG = false, -- true/false。有効にすると、メインループがティックされていないことを検出するウォッチドッグがプロセスを強制終了できなくなります。
    INACTIVITY_WATCHDOG_PERIOD  = 2000,  -- 非アクティブウォッチドッグが、ターゲットプロセスを強制終了する前に、メインループのティック間で待機する時間（ミリ秒）。
}
