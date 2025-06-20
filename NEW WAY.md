import React, { useState } from 'react';
import { Heart, Users, Moon, Star, AlertCircle, Sparkles, Info } from 'lucide-react';

const TarotCompatibilitySystem = () => {
  const [person1Date, setPerson1Date] = useState('');
  const [person2Date, setPerson2Date] = useState('');
  const [person1Name, setPerson1Name] = useState('');
  const [person2Name, setPerson2Name] = useState('');
  const [result, setResult] = useState(null);
  const [showDetails, setShowDetails] = useState({
    soul: false,
    personality: false,
    shadow: false
  });

  // 塔羅牌名稱
  const tarotCards = {
    1: '魔術師',
    2: '女祭司',
    3: '女帝',
    4: '皇帝',
    5: '教皇',
    6: '戀人',
    7: '戰車',
    8: '力量',
    9: '隱士',
    10: '命運之輪',
    11: '正義',
    12: '倒吊人',
    13: '死神',
    14: '節制',
    15: '惡魔',
    16: '高塔',
    17: '星星',
    18: '月亮',
    19: '太陽',
    20: '審判',
    21: '世界'
  };

  // 兼容性矩陣 - 基於元素、數字學和原型關係
  const compatibilityMatrix = {
    // 魔術師(1)
    1: {
      1: { score: 85, type: '鏡像關係', desc: '兩個創造者相遇，能量強大但需避免競爭' },
      2: { score: 75, type: '互補關係', desc: '行動與直覺的完美結合' },
      3: { score: 80, type: '創造關係', desc: '共同創造豐盛的可能' },
      4: { score: 70, type: '建設關係', desc: '意志與結構的結合' },
      5: { score: 65, type: '學習關係', desc: '創新與傳統的對話' },
      6: { score: 90, type: '和諧關係', desc: '創造力在愛中綻放' },
      7: { score: 85, type: '動力關係', desc: '共同推進目標' },
      8: { score: 80, type: '力量關係', desc: '意志與內在力量的結合' },
      9: { score: 60, type: '成長關係', desc: '外向與內向的平衡' },
      10: { score: 85, type: '機遇關係', desc: '創造力遇上機會' },
      11: { score: 70, type: '平衡關係', desc: '創造需要公正的評估' },
      12: { score: 65, type: '轉化關係', desc: '行動與等待的學習' },
      13: { score: 75, type: '重生關係', desc: '創造與轉化的循環' },
      14: { score: 80, type: '調和關係', desc: '創造力需要平衡' },
      15: { score: 70, type: '激情關係', desc: '創造力與慾望的結合' },
      16: { score: 75, type: '突破關係', desc: '創新帶來改變' },
      17: { score: 85, type: '靈感關係', desc: '創造力與希望相遇' },
      18: { score: 70, type: '直覺關係', desc: '意識與潛意識的對話' },
      19: { score: 90, type: '光明關係', desc: '創造力在陽光下綻放' },
      20: { score: 80, type: '覺醒關係', desc: '創造新的開始' },
      21: { score: 85, type: '完成關係', desc: '創造力達到圓滿' }
    },
    // 女祭司(2)
    2: {
      1: { score: 75, type: '互補關係', desc: '直覺引導行動' },
      2: { score: 85, type: '深度連結', desc: '心靈的深度共鳴' },
      3: { score: 80, type: '陰性力量', desc: '直覺與創造的結合' },
      4: { score: 65, type: '對立統一', desc: '陰性與陽性的平衡' },
      5: { score: 70, type: '靈性關係', desc: '內在與外在教導的結合' },
      6: { score: 85, type: '心靈關係', desc: '深度的情感連結' },
      7: { score: 60, type: '內外平衡', desc: '靜與動的學習' },
      8: { score: 75, type: '內在力量', desc: '直覺與力量的結合' },
      9: { score: 90, type: '靈魂關係', desc: '深度的靈性連結' },
      10: { score: 70, type: '命運關係', desc: '直覺感知命運' },
      11: { score: 75, type: '智慧關係', desc: '直覺與理性的平衡' },
      12: { score: 85, type: '神秘關係', desc: '共同的內在探索' },
      13: { score: 80, type: '轉化關係', desc: '深度的心靈轉化' },
      14: { score: 80, type: '靈性平衡', desc: '內在的和諧' },
      15: { score: 65, type: '陰影關係', desc: '面對內在陰影' },
      16: { score: 70, type: '啟示關係', desc: '直覺帶來洞察' },
      17: { score: 90, type: '神聖關係', desc: '靈性的指引' },
      18: { score: 95, type: '月光關係', desc: '潛意識的深度連結' },
      19: { score: 75, type: '光影關係', desc: '內在與外在的平衡' },
      20: { score: 85, type: '覺醒關係', desc: '靈性的覺醒' },
      21: { score: 80, type: '智慧圓滿', desc: '內在智慧的完成' }
    },
    // 女帝(3)
    3: {
      1: { score: 80, type: '創造關係', desc: '共創豐盛' },
      2: { score: 80, type: '陰性力量', desc: '母性與靈性的結合' },
      3: { score: 85, type: '豐盛關係', desc: '雙倍的創造力' },
      4: { score: 90, type: '完美配對', desc: '陰陽平衡的典範' },
      5: { score: 70, type: '成長關係', desc: '創造與指導' },
      6: { score: 95, type: '愛的化身', desc: '愛與美的極致表現' },
      7: { score: 75, type: '推進關係', desc: '創造力需要方向' },
      8: { score: 85, type: '溫柔力量', desc: '母性與力量的結合' },
      9: { score: 65, type: '內外關係', desc: '豐盛與簡樸的平衡' },
      10: { score: 80, type: '豐盛循環', desc: '創造的自然循環' },
      11: { score: 70, type: '公正創造', desc: '創造需要平衡' },
      12: { score: 75, type: '等待豐收', desc: '創造需要耐心' },
      13: { score: 70, type: '生死循環', desc: '創造與毀滅的自然法則' },
      14: { score: 85, type: '和諧創造', desc: '平衡的創造力' },
      15: { score: 65, type: '慾望關係', desc: '創造力與慾望' },
      16: { score: 60, type: '重建關係', desc: '破壞後的重建' },
      17: { score: 90, type: '希望關係', desc: '創造帶來希望' },
      18: { score: 75, type: '月光滋養', desc: '潛意識的滋養' },
      19: { score: 95, type: '陽光豐盛', desc: '最高的創造表現' },
      20: { score: 80, type: '新生關係', desc: '創造新的開始' },
      21: { score: 90, type: '圓滿豐盛', desc: '創造的最高境界' }
    },
    // 皇帝(4)
    4: {
      1: { score: 70, type: '建設關係', desc: '意志與結構' },
      2: { score: 65, type: '對立統一', desc: '理性與直覺' },
      3: { score: 90, type: '完美配對', desc: '帝后相配' },
      4: { score: 80, type: '權力關係', desc: '需要權力平衡' },
      5: { score: 85, type: '權威關係', desc: '世俗與精神權威' },
      6: { score: 70, type: '責任關係', desc: '權力與愛的平衡' },
      7: { score: 85, type: '征服關係', desc: '共同的目標' },
      8: { score: 80, type: '力量聯盟', desc: '不同形式的力量' },
      9: { score: 60, type: '對比關係', desc: '外在與內在的差異' },
      10: { score: 75, type: '掌控命運', desc: '控制與放手' },
      11: { score: 90, type: '公正統治', desc: '權力與正義' },
      12: { score: 55, type: '挑戰關係', desc: '控制與臣服的衝突' },
      13: { score: 85, type: '權力轉換', desc: '舊秩序的終結' },
      14: { score: 75, type: '穩定關係', desc: '權力需要節制' },
      15: { score: 70, type: '權力慾望', desc: '權力的陰暗面' },
      16: { score: 80, type: '權力崩塌', desc: '結構的瓦解' },
      17: { score: 65, type: '理想關係', desc: '權力與理想' },
      18: { score: 60, type: '意識差異', desc: '理性與非理性' },
      19: { score: 85, type: '光明統治', desc: '開明的領導' },
      20: { score: 80, type: '審判關係', desc: '權力的審判' },
      21: { score: 85, type: '完美統治', desc: '達到統治的最高境界' }
    },
    // 教皇(5)
    5: {
      1: { score: 65, type: '學習關係', desc: '創新與傳統' },
      2: { score: 70, type: '靈性關係', desc: '不同的靈性道路' },
      3: { score: 70, type: '成長關係', desc: '物質與精神' },
      4: { score: 85, type: '權威關係', desc: '兩種權威形式' },
      5: { score: 85, type: '同道關係', desc: '共同的信念' },
      6: { score: 75, type: '神聖之愛', desc: '精神與世俗之愛' },
      7: { score: 70, type: '信念行動', desc: '信念化為行動' },
      8: { score: 75, type: '精神力量', desc: '信念的力量' },
      9: { score: 90, type: '導師關係', desc: '精神導師' },
      10: { score: 70, type: '信仰考驗', desc: '信念與變化' },
      11: { score: 80, type: '道德關係', desc: '精神與法律' },
      12: { score: 85, type: '犧牲關係', desc: '精神的犧牲' },
      13: { score: 75, type: '信仰轉化', desc: '信念的死亡與重生' },
      14: { score: 90, type: '精神平衡', desc: '完美的精神和諧' },
      15: { score: 60, type: '誘惑關係', desc: '精神與物質的衝突' },
      16: { score: 70, type: '信仰崩塌', desc: '信念體系的瓦解' },
      17: { score: 85, type: '精神指引', desc: '信仰帶來希望' },
      18: { score: 75, type: '神秘教導', desc: '隱藏的智慧' },
      19: { score: 80, type: '光明教導', desc: '開悟的教導' },
      20: { score: 85, type: '精神覺醒', desc: '集體的覺醒' },
      21: { score: 80, type: '智慧傳承', desc: '完整的智慧體系' }
    },
    // 戀人(6)
    6: {
      1: { score: 90, type: '和諧關係', desc: '創造力在愛中綻放' },
      2: { score: 85, type: '心靈關係', desc: '深度的情感連結' },
      3: { score: 95, type: '愛的化身', desc: '愛與美的結合' },
      4: { score: 70, type: '責任關係', desc: '愛與責任' },
      5: { score: 75, type: '神聖之愛', desc: '世俗與神聖的愛' },
      6: { score: 90, type: '完美之愛', desc: '愛的最高表現' },
      7: { score: 75, type: '愛的方向', desc: '愛需要方向' },
      8: { score: 85, type: '愛的力量', desc: '愛就是力量' },
      9: { score: 65, type: '內外之愛', desc: '社交與獨處' },
      10: { score: 80, type: '命運之愛', desc: '愛的命運' },
      11: { score: 75, type: '公正之愛', desc: '愛需要平衡' },
      12: { score: 70, type: '犧牲之愛', desc: '愛的犧牲' },
      13: { score: 65, type: '愛的轉化', desc: '愛的死亡與重生' },
      14: { score: 85, type: '和諧之愛', desc: '完美的平衡' },
      15: { score: 90, type: '激情之愛', desc: '愛與慾望' },
      16: { score: 60, type: '愛的考驗', desc: '關係的崩塌' },
      17: { score: 90, type: '希望之愛', desc: '愛帶來希望' },
      18: { score: 75, type: '夢幻之愛', desc: '愛的幻想' },
      19: { score: 95, type: '光明之愛', desc: '純粹的愛' },
      20: { score: 80, type: '神聖結合', desc: '靈魂的結合' },
      21: { score: 90, type: '圓滿之愛', desc: '愛的最高境界' }
    },
    // 戰車(7)
    7: {
      1: { score: 85, type: '動力關係', desc: '共同推進' },
      2: { score: 60, type: '內外平衡', desc: '行動與靜止' },
      3: { score: 75, type: '推進關係', desc: '創造需要方向' },
      4: { score: 85, type: '征服關係', desc: '共同的征服' },
      5: { score: 70, type: '信念行動', desc: '將信念化為行動' },
      6: { score: 75, type: '愛的方向', desc: '為愛而戰' },
      7: { score: 80, type: '競爭關係', desc: '健康的競爭' },
      8: { score: 85, type: '雙重力量', desc: '意志與內在力量' },
      9: { score: 55, type: '速度差異', desc: '快與慢的衝突' },
      10: { score: 80, type: '掌控命運', desc: '駕馭命運之輪' },
      11: { score: 75, type: '公正勝利', desc: '正義的勝利' },
      12: { score: 60, type: '行動暫停', desc: '前進與等待' },
      13: { score: 70, type: '征服死亡', desc: '超越限制' },
      14: { score: 70, type: '控制平衡', desc: '速度需要節制' },
      15: { score: 75, type: '慾望驅動', desc: '被慾望驅動' },
      16: { score: 75, type: '突破障礙', desc: '衝破阻礙' },
      17: { score: 80, type: '理想追求', desc: '向理想前進' },
      18: { score: 65, type: '夜間旅程', desc: '在迷霧中前進' },
      19: { score: 90, type: '勝利之光', desc: '光明的勝利' },
      20: { score: 80, type: '最終勝利', desc: '達到最終目標' },
      21: { score: 85, type: '完成征途', desc: '旅程的完成' }
    },
    // 力量(8)
    8: {
      1: { score: 80, type: '力量關係', desc: '不同形式的力量' },
      2: { score: 75, type: '內在力量', desc: '直覺的力量' },
      3: { score: 85, type: '溫柔力量', desc: '母性的力量' },
      4: { score: 80, type: '力量聯盟', desc: '剛柔並濟' },
      5: { score: 75, type: '精神力量', desc: '信念的力量' },
      6: { score: 85, type: '愛的力量', desc: '愛就是最大的力量' },
      7: { score: 85, type: '雙重力量', desc: '內外力量的結合' },
      8: { score: 85, type: '力量共鳴', desc: '力量的倍增' },
      9: { score: 70, type: '靜默力量', desc: '不同的力量表達' },
      10: { score: 75, type: '命運力量', desc: '掌控命運的力量' },
      11: { score: 80, type: '公正力量', desc: '正義的力量' },
      12: { score: 75, type: '臣服力量', desc: '臣服也是力量' },
      13: { score: 80, type: '轉化力量', desc: '死亡與重生的力量' },
      14: { score: 85, type: '平衡力量', desc: '力量的完美平衡' },
      15: { score: 70, type: '原始力量', desc: '馴服原始慾望' },
      16: { score: 70, type: '重建力量', desc: '從廢墟中重建' },
      17: { score: 85, type: '希望力量', desc: '希望給予力量' },
      18: { score: 75, type: '直覺力量', desc: '潛意識的力量' },
      19: { score: 90, type: '光明力量', desc: '陽光般的力量' },
      20: { score: 85, type: '覺醒力量', desc: '覺醒的力量' },
      21: { score: 85, type: '圓滿力量', desc: '力量的最高境界' }
    },
    // 隱士(9)
    9: {
      1: { score: 60, type: '成長關係', desc: '外向與內向的學習' },
      2: { score: 90, type: '靈魂關係', desc: '深度的靈性連結' },
      3: { score: 65, type: '內外關係', desc: '豐盛與簡樸' },
      4: { score: 60, type: '對比關係', desc: '權力與智慧' },
      5: { score: 90, type: '導師關係', desc: '精神導師的相遇' },
      6: { score: 65, type: '內外之愛', desc: '獨處與相伴' },
      7: { score: 55, type: '速度差異', desc: '快與慢的平衡' },
      8: { score: 70, type: '靜默力量', desc: '內在的力量' },
      9: { score: 95, type: '智慧相遇', desc: '智者的共鳴' },
      10: { score: 65, type: '內在循環', desc: '內在的命運' },
      11: { score: 75, type: '智慧公正', desc: '智慧的判斷' },
      12: { score: 85, type: '內省關係', desc: '共同的內在探索' },
      13: { score: 80, type: '智慧轉化', desc: '通過智慧轉化' },
      14: { score: 80, type: '內在平衡', desc: '智慧的平衡' },
      15: { score: 60, type: '光影關係', desc: '面對內在陰影' },
      16: { score: 65, type: '內在重建', desc: '內在的重建' },
      17: { score: 85, type: '內在之光', desc: '內在的指引' },
      18: { score: 85, type: '夜間智慧', desc: '潛意識的智慧' },
      19: { score: 70, type: '內外光明', desc: '內在與外在的光' },
      20: { score: 80, type: '智慧覺醒', desc: '內在的覺醒' },
      21: { score: 85, type: '智慧圓滿', desc: '智慧的完成' }
    },
    // 命運之輪(10)
    10: {
      1: { score: 85, type: '機遇關係', desc: '創造機會' },
      2: { score: 70, type: '命運關係', desc: '感知命運' },
      3: { score: 80, type: '豐盛循環', desc: '自然的循環' },
      4: { score: 75, type: '掌控命運', desc: '控制與放手' },
      5: { score: 70, type: '信仰考驗', desc: '命運的考驗' },
      6: { score: 80, type: '命運之愛', desc: '命中注定的愛' },
      7: { score: 80, type: '掌控命運', desc: '駕馭命運' },
      8: { score: 75, type: '命運力量', desc: '改變命運的力量' },
      9: { score: 65, type: '內在循環', desc: '內在的命運輪迴' },
      10: { score: 85, type: '雙重命運', desc: '命運的交織' },
      11: { score: 75, type: '因果關係', desc: '命運的因果' },
      12: { score: 70, type: '命運等待', desc: '等待命運轉變' },
      13: { score: 85, type: '命運轉換', desc: '命運的死亡與重生' },
      14: { score: 80, type: '命運平衡', desc: '平衡的命運' },
      15: { score: 70, type: '命運束縛', desc: '被命運束縛' },
      16: { score: 80, type: '命運突變', desc: '命運的突然改變' },
      17: { score: 85, type: '幸運之星', desc: '好運的到來' },
      18: { score: 75, type: '命運迷霧', desc: '不確定的命運' },
      19: { score: 90, type: '幸運之光', desc: '光明的命運' },
      20: { score: 85, type: '命運審判', desc: '命運的最終審判' },
      21: { score: 85, type: '命運完成', desc: '命運的圓滿' }
    },
    // 正義(11)
    11: {
      1: { score: 70, type: '平衡關係', desc: '創造與評估' },
      2: { score: 75, type: '智慧關係', desc: '直覺與理性' },
      3: { score: 70, type: '公正創造', desc: '平衡的創造' },
      4: { score: 90, type: '公正統治', desc: '權力與正義' },
      5: { score: 80, type: '道德關係', desc: '法律與道德' },
      6: { score: 75, type: '公正之愛', desc: '愛的平衡' },
      7: { score: 75, type: '公正勝利', desc: '正義的勝利' },
      8: { score: 80, type: '公正力量', desc: '正義的力量' },
      9: { score: 75, type: '智慧公正', desc: '智慧的判斷' },
      10: { score: 75, type: '因果關係', desc: '因果法則' },
      11: { score: 85, type: '雙重正義', desc: '正義的共鳴' },
      12: { score: 65, type: '判斷暫停', desc: '暫停判斷' },
      13: { score: 70, type: '終極審判', desc: '最終的公正' },
      14: { score: 85, type: '完美平衡', desc: '正義與節制' },
      15: { score: 60, type: '道德考驗', desc: '正義與誘惑' },
      16: { score: 70, type: '正義崩塌', desc: '不公的瓦解' },
      17: { score: 80, type: '理想正義', desc: '正義的理想' },
      18: { score: 65, type: '隱藏真相', desc: '真相的迷霧' },
      19: { score: 85, type: '光明正義', desc: '真理之光' },
      20: { score: 90, type: '最終審判', desc: '終極的正義' },
      21: { score: 85, type: '宇宙正義', desc: '宇宙的平衡' }
    },
    // 倒吊人(12)
    12: {
      1: { score: 65, type: '轉化關係', desc: '行動與等待' },
      2: { score: 85, type: '神秘關係', desc: '內在的探索' },
      3: { score: 75, type: '等待豐收', desc: '耐心等待' },
      4: { score: 55, type: '挑戰關係', desc: '控制與臣服' },
      5: { score: 85, type: '犧牲關係', desc: '精神的犧牲' },
      6: { score: 70, type: '犧牲之愛', desc: '為愛犧牲' },
      7: { score: 60, type: '行動暫停', desc: '暫停前進' },
      8: { score: 75, type: '臣服力量', desc: '臣服的力量' },
      9: { score: 85, type: '內省關係', desc: '共同內省' },
      10: { score: 70, type: '命運等待', desc: '等待轉機' },
      11: { score: 65, type: '判斷暫停', desc: '暫緩判斷' },
      12: { score: 90, type: '共同犧牲', desc: '深度的理解' },
      13: { score: 85, type: '死亡準備', desc: '為轉化做準備' },
      14: { score: 80, type: '耐心平衡', desc: '等待中的平衡' },
      15: { score: 65, type: '束縛覺察', desc: '覺察束縛' },
      16: { score: 75, type: '崩塌前夕', desc: '改變前的等待' },
      17: { score: 80, type: '希望等待', desc: '在等待中保持希望' },
      18: { score: 85, type: '潛意識探索', desc: '深入潛意識' },
      19: { score: 70, type: '黎明前夕', desc: '等待光明' },
      20: { score: 80, type: '覺醒準備', desc: '準備覺醒' },
      21: { score: 75, type: '完成等待', desc: '等待圓滿' }
    },
    // 死神(13)
    13: {
      1: { score: 75, type: '重生關係', desc: '創造與毀滅' },
      2: { score: 80, type: '轉化關係', desc: '深度轉化' },
      3: { score: 70, type: '生死循環', desc: '自然循環' },
      4: { score: 85, type: '權力轉換', desc: '舊秩序終結' },
      5: { score: 75, type: '信仰轉化', desc: '信念的轉變' },
      6: { score: 65, type: '愛的轉化', desc: '關係的轉變' },
      7: { score: 70, type: '征服死亡', desc: '超越限制' },
      8: { score: 80, type: '轉化力量', desc: '轉化的力量' },
      9: { score: 80, type: '智慧轉化', desc: '智慧的轉變' },
      10: { score: 85, type: '命運轉換', desc: '命運的轉折' },
      11: { score: 70, type: '終極審判', desc: '最終的結算' },
      12: { score: 85, type: '死亡準備', desc: '轉化的準備' },
      13: { score: 90, type: '雙重轉化', desc: '深度的轉變' },
      14: { score: 80, type: '轉化平衡', desc: '平衡的轉變' },
      15: { score: 75, type: '陰影轉化', desc: '面對陰影' },
      16: { score: 85, type: '徹底改變', desc: '完全的轉變' },
      17: { score: 75, type: '重生希望', desc: '轉化帶來希望' },
      18: { score: 80, type: '潛意識死亡', desc: '深層的轉變' },
      19: { score: 80, type: '黑暗黎明', desc: '死亡後的光明' },
      20: { score: 85, type: '最終轉化', desc: '終極的重生' },
      21: { score: 80, type: '循環完成', desc: '生死的圓滿' }
    },
    // 節制(14)
    14: {
      1: { score: 80, type: '調和關係', desc: '創造的平衡' },
      2: { score: 80, type: '靈性平衡', desc: '內在和諧' },
      3: { score: 85, type: '和諧創造', desc: '平衡的創造' },
      4: { score: 75, type: '穩定關係', desc: '權力的節制' },
      5: { score: 90, type: '精神平衡', desc: '完美的和諧' },
      6: { score: 85, type: '和諧之愛', desc: '愛的平衡' },
      7: { score: 70, type: '控制平衡', desc: '速度的節制' },
      8: { score: 85, type: '平衡力量', desc: '力量的和諧' },
      9: { score: 80, type: '內在平衡', desc: '智慧的平衡' },
      10: { score: 80, type: '命運平衡', desc: '平衡的命運' },
      11: { score: 85, type: '完美平衡', desc: '正義與和諧' },
      12: { score: 80, type: '耐心平衡', desc: '等待的平衡' },
      13: { score: 80, type: '轉化平衡', desc: '平衡的轉變' },
      14: { score: 90, type: '雙重和諧', desc: '完美的平衡' },
      15: { score: 65, type: '極端平衡', desc: '平衡極端' },
      16: { score: 70, type: '重建平衡', desc: '崩塌後的平衡' },
      17: { score: 90, type: '希望平衡', desc: '和諧的希望' },
      18: { score: 75, type: '情緒平衡', desc: '平衡情緒' },
      19: { score: 85, type: '光明和諧', desc: '陽光般的和諧' },
      20: { score: 85, type: '神聖平衡', desc: '神聖的和諧' },
      21: { score: 90, type: '宇宙和諧', desc: '宇宙的平衡' }
    },
    // 惡魔(15)
    15: {
      1: { score: 70, type: '激情關係', desc: '創造與慾望' },
      2: { score: 65, type: '陰影關係', desc: '面對陰影' },
      3: { score: 65, type: '慾望關係', desc: '創造與慾望' },
      4: { score: 70, type: '權力慾望', desc: '權力的陰暗面' },
      5: { score: 60, type: '誘惑關係', desc: '精神的考驗' },
      6: { score: 90, type: '激情之愛', desc: '愛與慾望' },
      7: { score: 75, type: '慾望驅動', desc: '被慾望驅動' },
      8: { score: 70, type: '原始力量', desc: '原始的力量' },
      9: { score: 60, type: '光影關係', desc: '光明與黑暗' },
      10: { score: 70, type: '命運束縛', desc: '被命運束縛' },
      11: { score: 60, type: '道德考驗', desc: '正義的考驗' },
      12: { score: 65, type: '束縛覺察', desc: '覺察束縛' },
      13: { score: 75, type: '陰影轉化', desc: '轉化陰影' },
      14: { score: 65, type: '極端平衡', desc: '平衡極端' },
      15: { score: 85, type: '陰影共舞', desc: '共同面對陰影' },
      16: { score: 80, type: '束縛破除', desc: '打破枷鎖' },
      17: { score: 70, type: '黑暗之光', desc: '黑暗中的希望' },
      18: { score: 85, type: '潛意識慾望', desc: '深層的慾望' },
      19: { score: 75, type: '光影對比', desc: '極端的對比' },
      20: { score: 75, type: '陰影覺醒', desc: '覺醒的陰影' },
      21: { score: 70, type: '整合陰影', desc: '陰影的整合' }
    },
    // 高塔(16)
    16: {
      1: { score: 75, type: '突破關係', desc: '創新突破' },
      2: { score: 70, type: '啟示關係', desc: '直覺的洞察' },
      3: { score: 60, type: '重建關係', desc: '破壞與重建' },
      4: { score: 80, type: '權力崩塌', desc: '結構瓦解' },
      5: { score: 70, type: '信仰崩塌', desc: '信念動搖' },
      6: { score: 60, type: '愛的考驗', desc: '關係的考驗' },
      7: { score: 75, type: '突破障礙', desc: '衝破阻礙' },
      8: { score: 70, type: '重建力量', desc: '廢墟中重建' },
      9: { score: 65, type: '內在重建', desc: '內在的重建' },
      10: { score: 80, type: '命運突變', desc: '突然的改變' },
      11: { score: 70, type: '正義崩塌', desc: '不公的瓦解' },
      12: { score: 75, type: '崩塌前夕', desc: '改變的準備' },
      13: { score: 85, type: '徹底改變', desc: '完全的轉變' },
      14: { score: 70, type: '重建平衡', desc: '崩塌後的平衡' },
      15: { score: 80, type: '束縛破除', desc: '打破枷鎖' },
      16: { score: 85, type: '雙重崩塌', desc: '共同的改變' },
      17: { score: 75, type: '廢墟希望', desc: '廢墟中的希望' },
      18: { score: 70, type: '幻象破滅', desc: '幻覺的破滅' },
      19: { score: 80, type: '破曉時分', desc: '破壞後的光明' },
      20: { score: 85, type: '覺醒震撼', desc: '震撼的覺醒' },
      21: { score: 75, type: '破後重生', desc: '完全的重建' }
    },
    // 星星(17)
    17: {
      1: { score: 85, type: '靈感關係', desc: '創造的靈感' },
      2: { score: 90, type: '神聖關係', desc: '靈性的指引' },
      3: { score: 90, type: '希望關係', desc: '創造希望' },
      4: { score: 65, type: '理想關係', desc: '理想與現實' },
      5: { score: 85, type: '精神指引', desc: '信仰的希望' },
      6: { score: 90, type: '希望之愛', desc: '愛的希望' },
      7: { score: 80, type: '理想追求', desc: '追求理想' },
      8: { score: 85, type: '希望力量', desc: '希望的力量' },
      9: { score: 85, type: '內在之光', desc: '內在的指引' },
      10: { score: 85, type: '幸運之星', desc: '好運降臨' },
      11: { score: 80, type: '理想正義', desc: '正義的理想' },
      12: { score: 80, type: '希望等待', desc: '希望中等待' },
      13: { score: 75, type: '重生希望', desc: '轉化的希望' },
      14: { score: 90, type: '希望平衡', desc: '和諧的希望' },
      15: { score: 70, type: '黑暗之光', desc: '黑暗中的光' },
      16: { score: 75, type: '廢墟希望', desc: '廢墟中的希望' },
      17: { score: 95, type: '雙重希望', desc: '希望的共鳴' },
      18: { score: 80, type: '夢想希望', desc: '夢中的希望' },
      19: { score: 95, type: '光明希望', desc: '最高的希望' },
      20: { score: 90, type: '神聖希望', desc: '神聖的指引' },
      21: { score: 90, type: '宇宙希望', desc: '宇宙的祝福' }
    },
    // 月亮(18)
    18: {
      1: { score: 70, type: '直覺關係', desc: '意識與潛意識' },
      2: { score: 95, type: '月光關係', desc: '潛意識的共鳴' },
      3: { score: 75, type: '月光滋養', desc: '潛意識滋養' },
      4: { score: 60, type: '意識差異', desc: '理性與非理性' },
      5: { score: 75, type: '神秘教導', desc: '隱藏的智慧' },
      6: { score: 75, type: '夢幻之愛', desc: '愛的幻想' },
      7: { score: 65, type: '夜間旅程', desc: '迷霧中前進' },
      8: { score: 75, type: '直覺力量', desc: '潛意識力量' },
      9: { score: 85, type: '夜間智慧', desc: '潛意識智慧' },
      10: { score: 75, type: '命運迷霧', desc: '不確定的命運' },
      11: { score: 65, type: '隱藏真相', desc: '真相的迷霧' },
      12: { score: 85, type: '潛意識探索', desc: '深入潛意識' },
      13: { score: 80, type: '潛意識死亡', desc: '深層轉變' },
      14: { score: 75, type: '情緒平衡', desc: '平衡情緒' },
      15: { score: 85, type: '潛意識慾望', desc: '深層慾望' },
      16: { score: 70, type: '幻象破滅', desc: '幻覺破滅' },
      17: { score: 80, type: '夢想希望', desc: '夢中希望' },
      18: { score: 90, type: '雙重幻象', desc: '共同的夢境' },
      19: { score: 75, type: '月光日光', desc: '陰陽平衡' },
      20: { score: 80, type: '潛意識覺醒', desc: '深層覺醒' },
      21: { score: 80, type: '宇宙潛意識', desc: '集體潛意識' }
    },
    // 太陽(19)
    19: {
      1: { score: 90, type: '光明關係', desc: '創造的光明' },
      2: { score: 75, type: '光影關係', desc: '內外平衡' },
      3: { score: 95, type: '陽光豐盛', desc: '最高的創造' },
      4: { score: 85, type: '光明統治', desc: '開明的領導' },
      5: { score: 80, type: '光明教導', desc: '開悟的教導' },
      6: { score: 95, type: '光明之愛', desc: '純粹的愛' },
      7: { score: 90, type: '勝利之光', desc: '光明的勝利' },
      8: { score: 90, type: '光明力量', desc: '陽光的力量' },
      9: { score: 70, type: '內外光明', desc: '內外的光' },
      10: { score: 90, type: '幸運之光', desc: '光明的命運' },
      11: { score: 85, type: '光明正義', desc: '真理之光' },
      12: { score: 70, type: '黎明前夕', desc: '等待光明' },
      13: { score: 80, type: '黑暗黎明', desc: '死後的光明' },
      14: { score: 85, type: '光明和諧', desc: '陽光的和諧' },
      15: { score: 75, type: '光影對比', desc: '極端對比' },
      16: { score: 80, type: '破曉時分', desc: '破壞後的光明' },
      17: { score: 95, type: '光明希望', desc: '最高的希望' },
      18: { score: 75, type: '月光日光', desc: '陰陽平衡' },
      19: { score: 95, type: '雙重光明', desc: '光明的共鳴' },
      20: { score: 90, type: '光明覺醒', desc: '光明的覺醒' },
      21: { score: 95, type: '宇宙光明', desc: '宇宙的光輝' }
    },
    // 審判(20)
    20: {
      1: { score: 80, type: '覺醒關係', desc: '創造新開始' },
      2: { score: 85, type: '覺醒關係', desc: '靈性覺醒' },
      3: { score: 80, type: '新生關係', desc: '創造新生' },
      4: { score: 80, type: '審判關係', desc: '權力的審判' },
      5: { score: 85, type: '精神覺醒', desc: '集體覺醒' },
      6: { score: 80, type: '神聖結合', desc: '靈魂結合' },
      7: { score: 80, type: '最終勝利', desc: '最終目標' },
      8: { score: 85, type: '覺醒力量', desc: '覺醒的力量' },
      9: { score: 80, type: '智慧覺醒', desc: '內在覺醒' },
      10: { score: 85, type: '命運審判', desc: '最終審判' },
      11: { score: 90, type: '最終審判', desc: '終極正義' },
      12: { score: 80, type: '覺醒準備', desc: '準備覺醒' },
      13: { score: 85, type: '最終轉化', desc: '終極重生' },
      14: { score: 85, type: '神聖平衡', desc: '神聖和諧' },
      15: { score: 75, type: '陰影覺醒', desc: '覺醒陰影' },
      16: { score: 85, type: '覺醒震撼', desc: '震撼覺醒' },
      17: { score: 90, type: '神聖希望', desc: '神聖指引' },
      18: { score: 80, type: '潛意識覺醒', desc: '深層覺醒' },
      19: { score: 90, type: '光明覺醒', desc: '光明覺醒' },
      20: { score: 90, type: '雙重覺醒', desc: '共同覺醒' },
      21: { score: 95, type: '最終完成', desc: '終極圓滿' }
    },
    // 世界(21)
    21: {
      1: { score: 85, type: '完成關係', desc: '創造圓滿' },
      2: { score: 80, type: '智慧圓滿', desc: '內在完成' },
      3: { score: 90, type: '圓滿豐盛', desc: '創造的最高境界' },
      4: { score: 85, type: '完美統治', desc: '統治的最高境界' },
      5: { score: 80, type: '智慧傳承', desc: '完整的智慧' },
      6: { score: 90, type: '圓滿之愛', desc: '愛的最高境界' },
      7: { score: 85, type: '完成征途', desc: '旅程完成' },
      8: { score: 85, type: '圓滿力量', desc: '力量的最高境界' },
      9: { score: 85, type: '智慧圓滿', desc: '智慧完成' },
      10: { score: 85, type: '命運完成', desc: '命運圓滿' },
      11: { score: 85, type: '宇宙正義', desc: '宇宙平衡' },
      12: { score: 75, type: '完成等待', desc: '等待圓滿' },
      13: { score: 80, type: '循環完成', desc: '生死圓滿' },
      14: { score: 90, type: '宇宙和諧', desc: '宇宙平衡' },
      15: { score: 70, type: '整合陰影', desc: '陰影整合' },
      16: { score: 75, type: '破後重生', desc: '完全重建' },
      17: { score: 90, type: '宇宙希望', desc: '宇宙祝福' },
      18: { score: 80, type: '宇宙潛意識', desc: '集體潛意識' },
      19: { score: 95, type: '宇宙光明', desc: '宇宙光輝' },
      20: { score: 95, type: '最終完成', desc: '終極圓滿' },
      21: { score: 95, type: '雙重圓滿', desc: '完美的完成' }
    }
  };

  // 計算生命靈數
  const calculateTarotCards = (date) => {
    const digits = date.replace(/-/g, '').split('').map(Number);
    let total = digits.reduce((sum, digit) => sum + digit, 0);
    
    while (total > 21) {
      const newDigits = total.toString().split('').map(Number);
      total = newDigits.reduce((sum, digit) => sum + digit, 0);
    }
    
    const soulCard = total;
    let personalityCard;
    
    if (soulCard < 10) {
      personalityCard = soulCard;
    } else {
      const personalityDigits = soulCard.toString().split('').map(Number);
      personalityCard = personalityDigits.reduce((sum, digit) => sum + digit, 0);
    }
    
    // 計算陰影牌 (Shadow Card) - 使用 22 減去靈魂牌
    let shadowCard = 22 - soulCard;
    if (shadowCard <= 0) {
      shadowCard = Math.abs(shadowCard) + 1;
    }
    if (shadowCard > 21) {
      shadowCard = shadowCard - 21;
    }
    
    return {
      soulCard,
      personalityCard,
      shadowCard
    };
  };

  // 獲取兼容性分析
  const getCompatibility = (card1, card2) => {
    if (compatibilityMatrix[card1] && compatibilityMatrix[card1][card2]) {
      return compatibilityMatrix[card1][card2];
    }
    // 如果沒有直接對應，返回反向查詢
    if (compatibilityMatrix[card2] && compatibilityMatrix[card2][card1]) {
      return compatibilityMatrix[card2][card1];
    }
    // 默認兼容性
    return { score: 70, type: '獨特關係', desc: '需要深入探索的獨特連結' };
  };

  // 獲取綜合兼容性評分和建議
  const getOverallCompatibility = (soulComp, personalityComp, shadowComp) => {
    const avgScore = (soulComp.score + personalityComp.score + shadowComp.score) / 3;
    
    let level = '';
    let advice = '';
    
    if (avgScore >= 85) {
      level = '靈魂伴侶';
      advice = '你們有著深刻的靈魂連結，彼此能夠相互理解和支持。這是一段具有巨大潛力的關係。';
    } else if (avgScore >= 75) {
      level = '高度契合';
      advice = '你們在多個層面上都有良好的共鳴，通過相互學習可以達到更深的連結。';
    } else if (avgScore >= 65) {
      level = '互補成長';
      advice = '你們的差異可以成為彼此成長的催化劑，關鍵是保持開放和理解。';
    } else if (avgScore >= 55) {
      level = '挑戰與機遇';
      advice = '這段關係需要更多的努力和理解，但也蘊含著深刻的成長機會。';
    } else {
      level = '學習關係';
      advice = '你們相遇是為了學習重要的人生課題，保持耐心和慈悲是關鍵。';
    }
    
    return { avgScore: Math.round(avgScore), level, advice };
  };

  const handleAnalyze = () => {
    if (!person1Date || !person2Date || !person1Name || !person2Name) {
      alert('請填寫所有資訊');
      return;
    }
    
    const person1Cards = calculateTarotCards(person1Date);
    const person2Cards = calculateTarotCards(person2Date);
    
    const soulCompatibility = getCompatibility(person1Cards.soulCard, person2Cards.soulCard);
    const personalityCompatibility = getCompatibility(person1Cards.personalityCard, person2Cards.personalityCard);
    const shadowCompatibility = getCompatibility(person1Cards.shadowCard, person2Cards.shadowCard);
    
    const overall = getOverallCompatibility(soulCompatibility, personalityCompatibility, shadowCompatibility);
    
    setResult({
      person1: { name: person1Name, ...person1Cards },
      person2: { name: person2Name, ...person2Cards },
      compatibility: {
        soul: soulCompatibility,
        personality: personalityCompatibility,
        shadow: shadowCompatibility,
        overall
      }
    });
  };

  const getScoreColor = (score) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 75) return 'text-blue-600';
    if (score >= 65) return 'text-yellow-600';
    return 'text-orange-600';
  };

  const getScoreBg = (score) => {
    if (score >= 85) return 'bg-green-100';
    if (score >= 75) return 'bg-blue-100';
    if (score >= 65) return 'bg-yellow-100';
    return 'bg-orange-100';
  };

  return (
    <div className="max-w-4xl mx-auto p-6 bg-gradient-to-br from-purple-50 via-pink-50 to-indigo-50 rounded-xl shadow-xl">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-purple-800 mb-2 flex items-center justify-center gap-2">
          <Heart className="w-8 h-8" />
          塔羅牌雙人兼容性分析系統
        </h1>
        <p className="text-gray-600">深入分析兩人的靈魂契合度、個性相容性與陰影整合潛力</p>
      </div>

      <div className="grid md:grid-cols-2 gap-6 mb-6">
        <div className="bg-white rounded-lg p-6 shadow-md">
          <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Users className="w-5 h-5" />
            第一位
          </h3>
          <input
            type="text"
            placeholder="姓名"
            value={person1Name}
            onChange={(e) => setPerson1Name(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-md mb-3 focus:ring-2 focus:ring-purple-500"
          />
          <input
            type="date"
            value={person1Date}
            onChange={(e) => setPerson1Date(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-purple-500"
          />
        </div>

        <div className="bg-white rounded-lg p-6 shadow-md">
          <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
            <Users className="w-5 h-5" />
            第二位
          </h3>
          <input
            type="text"
            placeholder="姓名"
            value={person2Name}
            onChange={(e) => setPerson2Name(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-md mb-3 focus:ring-2 focus:ring-purple-500"
          />
          <input
            type="date"
            value={person2Date}
            onChange={(e) => setPerson2Date(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-purple-500"
          />
        </div>
      </div>

      <button
        onClick={handleAnalyze}
        className="w-full bg-gradient-to-r from-purple-600 to-pink-600 text-white py-3 rounded-md hover:from-purple-700 hover:to-pink-700 transition-colors font-semibold"
      >
        分析兼容性
      </button>

      {result && (
        <div className="mt-8 space-y-6">
          {/* 個人卡牌資訊 */}
          <div className="grid md:grid-cols-2 gap-6">
            <div className="bg-white rounded-lg p-6 shadow-md">
              <h3 className="font-semibold text-gray-800 mb-4">{result.person1.name}的生命牌</h3>
              <div className="space-y-2 text-sm">
                <p><span className="font-medium">靈魂牌：</span>{result.person1.soulCard} - {tarotCards[result.person1.soulCard]}</p>
                <p><span className="font-medium">個性牌：</span>{result.person1.personalityCard} - {tarotCards[result.person1.personalityCard]}</p>
                <p><span className="font-medium">陰影牌：</span>{result.person1.shadowCard} - {tarotCards[result.person1.shadowCard]}</p>
              </div>
            </div>

            <div className="bg-white rounded-lg p-6 shadow-md">
              <h3 className="font-semibold text-gray-800 mb-4">{result.person2.name}的生命牌</h3>
              <div className="space-y-2 text-sm">
                <p><span className="font-medium">靈魂牌：</span>{result.person2.soulCard} - {tarotCards[result.person2.soulCard]}</p>
                <p><span className="font-medium">個性牌：</span>{result.person2.personalityCard} - {tarotCards[result.person2.personalityCard]}</p>
                <p><span className="font-medium">陰影牌：</span>{result.person2.shadowCard} - {tarotCards[result.person2.shadowCard]}</p>
              </div>
            </div>
          </div>

          {/* 總體兼容性 */}
          <div className="bg-gradient-to-r from-purple-100 to-pink-100 rounded-lg p-6 text-center">
            <h3 className="text-2xl font-bold text-purple-800 mb-2">
              總體兼容性：{result.compatibility.overall.level}
            </h3>
            <div className="text-4xl font-bold text-purple-900 mb-4">
              {result.compatibility.overall.avgScore}%
            </div>
            <p className="text-gray-700 max-w-2xl mx-auto">
              {result.compatibility.overall.advice}
            </p>
          </div>

          {/* 詳細兼容性分析 */}
          <div className="space-y-4">
            {/* 靈魂牌兼容性 */}
            <div className="bg-white rounded-lg p-6 shadow-md">
              <div 
                className="flex items-center justify-between cursor-pointer"
                onClick={() => setShowDetails({...showDetails, soul: !showDetails.soul})}
              >
                <h3 className="font-semibold text-gray-800 flex items-center gap-2">
                  <Sparkles className="w-5 h-5 text-purple-600" />
                  靈魂層面兼容性
                </h3>
                <div className="flex items-center gap-4">
                  <span className={`text-2xl font-bold ${getScoreColor(result.compatibility.soul.score)}`}>
                    {result.compatibility.soul.score}%
                  </span>
                  <span className={`px-3 py-1 rounded-full text-sm ${getScoreBg(result.compatibility.soul.score)}`}>
                    {result.compatibility.soul.type}
                  </span>
                </div>
              </div>
              
              {showDetails.soul && (
                <div className="mt-4 pt-4 border-t">
                  <p className="text-gray-700 mb-2">{result.compatibility.soul.desc}</p>
                  <div className="flex items-center gap-4 text-sm text-gray-600">
                    <span>{tarotCards[result.person1.soulCard]} × {tarotCards[result.person2.soulCard]}</span>
                  </div>
                </div>
              )}
            </div>

            {/* 個性牌兼容性 */}
            <div className="bg-white rounded-lg p-6 shadow-md">
              <div 
                className="flex items-center justify-between cursor-pointer"
                onClick={() => setShowDetails({...showDetails, personality: !showDetails.personality})}
              >
                <h3 className="font-semibold text-gray-800 flex items-center gap-2">
                  <Star className="w-5 h-5 text-pink-600" />
                  個性層面兼容性
                </h3>
                <div className="flex items-center gap-4">
                  <span className={`text-2xl font-bold ${getScoreColor(result.compatibility.personality.score)}`}>
                    {result.compatibility.personality.score}%
                  </span>
                  <span className={`px-3 py-1 rounded-full text-sm ${getScoreBg(result.compatibility.personality.score)}`}>
                    {result.compatibility.personality.type}
                  </span>
                </div>
              </div>
              
              {showDetails.personality && (
                <div className="mt-4 pt-4 border-t">
                  <p className="text-gray-700 mb-2">{result.compatibility.personality.desc}</p>
                  <div className="flex items-center gap-4 text-sm text-gray-600">
                    <span>{tarotCards[result.person1.personalityCard]} × {tarotCards[result.person2.personalityCard]}</span>
                  </div>
                </div>
              )}
            </div>

            {/* 陰影牌兼容性 */}
            <div className="bg-white rounded-lg p-6 shadow-md">
              <div 
                className="flex items-center justify-between cursor-pointer"
                onClick={() => setShowDetails({...showDetails, shadow: !showDetails.shadow})}
              >
                <h3 className="font-semibold text-gray-800 flex items-center gap-2">
                  <Moon className="w-5 h-5 text-indigo-600" />
                  陰影整合兼容性
                </h3>
                <div className="flex items-center gap-4">
                  <span className={`text-2xl font-bold ${getScoreColor(result.compatibility.shadow.score)}`}>
                    {result.compatibility.shadow.score}%
                  </span>
                  <span className={`px-3 py-1 rounded-full text-sm ${getScoreBg(result.compatibility.shadow.score)}`}>
                    {result.compatibility.shadow.type}
                  </span>
                </div>
              </div>
              
              {showDetails.shadow && (
                <div className="mt-4 pt-4 border-t">
                  <p className="text-gray-700 mb-2">{result.compatibility.shadow.desc}</p>
                  <div className="flex items-center gap-4 text-sm text-gray-600">
                    <span>{tarotCards[result.person1.shadowCard]} × {tarotCards[result.person2.shadowCard]}</span>
                  </div>
                  <div className="mt-3 p-3 bg-gray-50 rounded-lg">
                    <p className="text-sm text-gray-600">
                      <Info className="w-4 h-4 inline mr-1" />
                      陰影牌代表需要整合的潛意識面向，兩人共同面對陰影可以帶來深層的療癒與成長。
                    </p>
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* 關係建議 */}
          <div className="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-lg p-6">
            <h3 className="font-semibold text-gray-800 mb-4 flex items-center gap-2">
              <AlertCircle className="w-5 h-5" />
              關係發展建議
            </h3>
            <div className="space-y-3 text-sm text-gray-700">
              <p>• <strong>靈魂連結：</strong>定期進行深度對話，分享內心的夢想和恐懼</p>
              <p>• <strong>個性互動：</strong>尊重彼此的差異，將其視為學習和成長的機會</p>
              <p>• <strong>陰影整合：</strong>當衝突出現時，觀察是否觸發了彼此的陰影面向</p>
              <p>• <strong>共同成長：</strong>設定共同的靈性或個人成長目標，相互支持</p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default TarotCompatibilitySystem;