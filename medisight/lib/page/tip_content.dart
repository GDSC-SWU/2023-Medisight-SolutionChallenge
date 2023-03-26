import 'package:flutter/material.dart';

class TipContentPage extends StatelessWidget {
  final List<Map<String, Object>> content = [
    {
      "title": "포장지와 함께 보관하기",
      "subtitle": "포장지와 함께 보관해주세요",
      "details": [
        "상비약의 경우 박스로 포장되어있다면, 박스에 의약품 정보를 확인할 수 있는 바코드가 부착되어 있으므로 최대한 박스에 넣어 같이 보관하는 것이 안전합니다.",
        "처방약의 경우 처방전 봉투에 처방된 의약품의 정보를 확인할 수 있는 바코드가 부착되어 있습니다. 꼭 처방전 봉투에 넣어 안전하게 보관해주세요.",
      ]
    },
    {
      "title": "유효기간 주의사항",
      "subtitle": "유효기간을 꼭 확인하세요",
      "details": [
        "유효기간이 지난 의약품은 효능 및 효과가 현저히 떨어집니다. 또한 유효기간이 지난 약은 약효를 나타내는 물질이 분해되고, 독성을 나타내는 다른 화학물질이 생성되어 있을 가능성도 있습니다. 따라서 의약품을 복용하기 전 꼭 유효기간을 확인해 주세요.",
        "또한, 포장지에 적혀있는 유효기간은 의약품 개봉 전 유효기간으로, 개봉 후에는 유효기간이 달라집니다. 개봉 후 유효기간을 확인하고복용해 주세요. 한국병원약사회 질향상위원회에서 제공하는 개봉 후 유효기간은 다음과 같습니다."
      ]
    },
    {
      "title": "어린이 상비약 안전마개",
      "subtitle": "우리 아이 약 뚜껑이 열리지 않아요!",
      "details": [
        "어린이 상비약은 어린이의 오용을 방지하기 위해 보호 캡이 사용된 경우가 많습니다. 보호캡은 반드시 적당한 힘을 주어 누르며 오른쪽 방향으로 돌려야 열립니다. 힘을 주지 않고 오른쪽으로 돌리면 열리지 않습니다."
      ]
    },
    {
      "title": "인공눈물 개봉 주의사항",
      "subtitle": "일회용 인공 눈물과 미세 플라스틱",
      "details": [
        "일회용 인공 눈물은 낱개 포장 끝의 마개를 돌려 개봉하는 방식입니다. 그런데 마개를 개봉한 후 반드시 최초 한 방울을 버리고 사용해야 한다는 점, 알고 계셨나요? 마개를 개봉하고 바로 우리 눈에 사용하면 개봉하면서 발생한 미세 플라스틱이 눈에 침투할 수 있습니다. 반드시 사용 전 한 방울을 버려주세요."
      ]
    },
    {
      "title": "의약품 복약시간",
      "subtitle": "약의 복용시간",
      "details": [
        "약의 복용시간은 정확히 지키고 충분한 물과 함께 복용해야 합니다.",
        "의약품의 복용시간 준수는 약물의 인체내 흡수 및 이에 따른 치료율 향상과 큰 연관관계가 있으므로 반드시 의사, 약사의 지시에 따라 복용하여야 합니다.",
        "인체의 생체리듬에 따라 다음과 같은 복용 시간대로 크게 나누어 볼 수 있습니다.",
        "식후 30분",
        "식사 후 30분 뒤에 복용하는 것입니다. 섭취한 음식이 위점막을 보호하기 때문에 복용 한 약의 위점막에 대한 자극이 적습니다. 약의 복용방법은 대부분이 식후입니다.",
        "식후 즉시",
        "철분제제 등 위장장애가 있는 약이나, 일부 향진균제와 같이 소화기관내의 식사직후 PH가 약물흡수를 더 용이하게 할 경우, 식사직후에 복용하게 됩니다.",
        "식간",
        "음식물이 소화된 후 공복을 느끼는 시간대, 즉 공복시에 복용하는 것입니다. 대체로 식사 후 1시간부터 다음 식사전 1시간 사이에 복용하시면 됩니다.",
        "식전 30분",
        "식욕을 증진시키는 약이나 구토를 억제하는 약 식사에 의해 약의 흡수가 방해되는 약은 이 시간대에 복용하게 됩니다.",
        "매( )시간마다 복용",
        "식사여부에 관계없이 일정간격으로 복용해야 하는 경우입니다. 이렇게 지시되는 대부분의 항생제나 화학요법제와 같은 약들은 인체내 약물의 농도가 일정하게 유지 되어야 할 필요가 있는 경우의 것 입니다. 양약뿐 아니라 한약의 경우에도 이런 것은 마찬가지로 해당됩니다.",
        "기타 지시된 시간",
        "취침전, 식전 20분, 아침식사후 등이나 1일 ( )회 복용의 지시가 있는 경우 인체의 생리리듬과 약물의 인체내 혈중반감시간 등을 고려하여 지시하는 약의 경우이므로 지시에 충실히 따르면 됩니다.",
        "복용 시간을 잊었을 때",
        "약 먹는 시간을 놓쳤을 때는 생각난 즉시 복용하도록 하나, 단 다음 복용시간이 가까운 경우에는 미루도록 합니다. 2회분을 연속적으로 복용하거나 동시에 먹어서는 안됩니다."
      ]
    },
    {
      "title": "복약시 음용수",
      "subtitle": "복약시 물을 얼마나 마셔야할까요?",
      "details": [
        "의약품 복용시 물 1컵, 240cc 정도의 물을 마시는 것이 좋습니다. 물 없이 약을 복용할 경우, 약의 성분에 따라서 약이 식도에 잔류하는데 이는 식도를 자극하고 식도 궤양이 생기는 등의 문제가 발생할 수도 있기 때문에 충분한 양의 물을 마시는 것이 중요합니다.",
        "또한 가급적 따뜻한 물로 복용하는 것이 좋은데 너무 찬물로 복용을 하게 되면 위점막의 흡수력이 저하될 수도 있기 때문입니다. 차나 커피, 음료수로 약을 먹는 것도 약물의 효과를 떨어뜨리거나 위장장애의 위험이 커지므로 약은 물로만 복용하여 주시길 바랍니다."
      ]
    },
    {
      "title": "병용금기 의약품",
      "subtitle": "이 약 같이 먹으면 안돼요",
      "details": [
        "병용금기 성분\n두 가지 이상의 유효성분을 함께 사용하는 경우 치료효과의 변화 또는 심각한 부작용 발생 등의 우려가 있어 동시에 사용하지 않아야 하는 유효성분의 조합을 말합니다. 다만, 의사의 판단 하에 치료적 유익성과 위험성을 고려하여 처방이 가능합니다.",
        "당뇨병약과 항생제 / 결핵약 / 소염진통제\n배설을 억제시켜 혈당수치가 올라감 저혈당 유발",
        "제산제와 다른 약물\n다른 약물의 흡수를 차단하여 효과를 볼 수 없음",
        "피임약과 항생제\n피임 효과를 떨어뜨림",
        "무좀약과 알레르기약\n무좀약이 알레르기약 성분의 배출을 막아 치명적인 부작용 유발",
        "소염진통제와 아스피린\n심장마비, 빈혈, 위출혈, 신장 합병증 발생 위험도 높임",
        "진통제와 종합감기약\n진통 억제 성분 과다 복용으로 위험",
        "관절염약과 수면제\n간에 무리를 주며, 사망 위험도 높임",
        "진통제과 두통약\n진통 억제 성분 과잉으로 속 쓰림, 위궤양 유발",
        "고혈압약과 소염진통제\n혈압약의 효과를 떨어뜨려 혈압이 일시적으로 높아짐",
        "무좀약과 발기부전치료제\n혈중 농도를 높여 심장에 이상 유발"
      ]
    },
    {
      "title": "의약품별 상호작용 식품",
      "subtitle": "알고 먹으면 약, 모르고 먹으면 독",
      "details": [
        "감기약과 카페인",
        "대표적으로 판콜, 판피린, 펜잘 등의 감기약이나 진통제에 지속시간을 늘리고 그 효과를 더하기 위해 카페인을 함유하고 있는 약이 있습니다. 커피나 홍차를 많이 마실 경우, 카페인 과다로 위염, 신경과민, 두통, 불안, 불면 등이 나타날 수 있습니다.",
        "빈혈약과 녹차",
        "철분제를 복용하실 때는 다른 약이나 음식과는 간격을 두고 드시는 편이 좋습니다. 녹차나 커피, 홍차 등에 들어간 탄닌이나 카페인은 철분 흡수를 방해합니다. 뿐만 아니라 칼슘이나 아연과 같은 2가 양이온의 경우에도 철분과 경쟁적으로 작용해서 흡수를 낮출 수 있습니다. 아예 섭취를 하지 말라는 것은 아니고 철분제를 드실 때는 2시간 간격으로 두시는 것이 좋습니다.",
        "변비약과 우유",
        "변비약은 장용정, 즉 약이 위가 아니라 장에서 작용하도록 코팅해놓은 것을 말하는데 우유를 마시게 되면 위의 산성 상태가 약해져 이 약이 위에서 녹아서 작용할 가능성이 큽니다. 만약 그렇게 되면 약 효과가 나지 않을 뿐더러 위장장애가 생길 수 있습니다.",
        "고혈압약과 바나나",
        "바나나와 토마토에는 칼륨이 많이 함유되어 있어 혈압을 높이는 나트륨의 배출을 돕습니다. 하지만 알닥톤 같은 칼륨 보존성 이뇨제나 신장이 안좋으신 분들은 칼륨의 수치가 높아지는 증상을 유발하기 때문에 오히려 바나나를 피해주시는 것이 좋습니다.",
        "고지혈증약과 자몽주스",
        "자몽과 자몽주스에 함유되어 있는 후라노쿠마린은 약물을 배출하는 CYP450의 작용을 방해할 수도 있습니다. 고지혈증약 중 일부 스타틴 계열의 약물은 자몽 주스 한잔과 복용했을 때, 그 효과가 2배 이상으로 증가할 수 있는데 이는 제대로된 약물 효과를 기대할 수 없습니다.",
        "피임약과 인삼, 홍삼",
        "인삼과 홍삼에 들어있는 진세노사이드라는 성분은 여성호르몬과 구조가 유사합니다. 피임약을 인삼 혹은 홍삼과 동시에 먹을 경우 여성 호르몬의 수치가 높게 올라갈 수 있습니다. 그래서 자궁근종이나 자궁내막암, 유방암 등이 있으신 분들에게는 동시에 복용하시는 것을 조심하셔야 합니다.",
      ]
    },
    {
      "title": "기저질환에 따른 복약시 유의사항",
      "subtitle": "질환별 의약품 복용방법 주의사항",
      "details": [
        "심혈관계 질환",
        "고혈압 치료제(혈압약)",
        "혈압약은 증상이 있을 때만 복용하는 것이 아니라 꾸준한 복용이 필요합니다. 지속해서 적절한 수준의 혈압을 유지해야 주요 장기의 손상을 예방하고, 다른 심혈관 질환의 발생률과 사망률을 낮출 수 있습니다.",
        "혈압약을 처음 복용할 때는 ‘기립성 저혈압’  을 주의해야 합니다. 이는 일시적 현상으로 심하지 않으면 시간이 지나가면서 점차 나아집니다.",
        "히드로클로로티아지드, 스피로노락톤 성분 등의 이뇨제는 처음에는 소변의 횟수가 증가할 수 있으므로 가능하면 아침 일찍 복용하는 것이 좋습니다.",
        "아테놀올, 비소프롤롤 성분 등 교감신경 차단제의 경우에는 갑자기 복용을 중단할 경우 반사적으로 심장 박동이 빨라질 수 있으므로 의사의 처방없이 임의로 의약품 복용을 중단하지 않아야 합니다.",
        "암로디핀 성분 등 칼슘 채널 차단제의 경우 이유 없이 발등이 붓거나 두통이 있는 경우 처방 의사와 상담하여야 합니다.",
        "협심증 및 심근경색 치료제",
        "니트로글리세린의 경우 응급약으로 항상 소지해야 하며, 증상이 있을 때 혀 밑에 넣는 설하정으로 물과 삼키면 안 됩니다. 또한 복용 후 어지러울 수 있으니 주의하여야 합니다.",
        "피부에 붙이는 패치제의 경우 1일 1매 매일 같은 시간에 부착하며 내성 방지를 위하여 12시간은 붙이고 12시간은 떼어 놓습니다.",
        "당뇨병 치료제",
        "메트포르민 성분을 포함한 의약품은 꼭 식사 직후 또는 식사 중에 복용해야 하며, 충분한 양의 물을 마시도록 합니다.",
        "메트포르민은 구토, 설사, 오심, 금속성맛 등의 위장장애와 같은 부작용을 최소화하기 위해서 식사 후 복용을 지켜야 합니다.",
        "보글리보스 성분의 경우 탄수화물을 분해하고 흡수하는 속도를 지연시켜 식사 후 혈당이 갑작스럽게 올라가는 것을 막기 위해서 식사 전에 복용해야 합니다. 위장관에서 당분의 흡수를 억제하다 보니 소화가 잘 되지 않아 가스가 찰 수 있습니다. 이때 소화제와 함께 복용해서는 안 됩니다.",
        "글리메피리드 성분과 같이 인슐린 분비를 촉진하는 의약품은 식사 전에 복용해야 합니다. 이 의약품을 식사 전에 복용하면 식사 후 인슐린의 분비를 촉진하여 혈당을 떨어뜨립니다. 의약품 복용 후 식사를 건너뛰면 저혈당이 올 수 있기 때문에 주의해야 합니다.",
        "고지혈증 치료제",
        "심바스타틴, 로바스타틴 등 성분 의약품의    경우 콜레스테롤 합성에 필요한 효소를 저해하는 작용을 하는데, 우리 몸에서 콜레스테롤의 합성은 주로 밤에 활발하게 이루어지므로 저녁에 복용하는 것이 약효를 크게 할 수 있는 방법입니다.",
        "대부분의 고지혈증 의약품이 콜레스테롤의 합성이 활발한 저녁 시간에 복용하는 것이 효과적이나, 아토르바스타틴, 로수바스타틴 성분의 겨우 작용 시간이 길고 지속적이어서 시간에 관계없이 복용해도 됩니다."
      ]
    },
    {
      "title": "두통약 성분",
      "subtitle": "두통약 성분",
      "details": [
        "아세트아미노펜",
        "해열진통제, 해열과 진통 역할에 효과",
        "디클로랄페나존",
        "안정 및 진정 작용을 하며 통증 경감 작용",
        "이소메텝텐",
        "복합 두통약에 대부분 포함된 성분, 아세트아미노펜과 병용(함께 복용)하면 효과적"
      ]
    },
    {
      "title": "해열제 성분",
      "subtitle": "해열제 성분",
      "details": [
        "아세트아미노펜",
        "해열진통제제, 해열과 진통 역할에 효과",
        "비스테로이드 항염증약(NSAIDs)",
        "진통/해열 작용과항염증 작용, 아스피린과 이부프로펜을 포함"
      ]
    },
    {
      "title": "소화제 성분",
      "subtitle": "소화제 성분",
      "details": [
        "소화효소제",
        "판크레아틴",
        "탄수화물, 단백질, 지방 모두 소화시키는 효소",
        "프로테아제, 브로멜라인, 프로자임, 판푸로신",
        "단백질 소화를 도움",
        "셀룰라제",
        "섬유소의 소화 도움",
        "가스제거제",
        "시메티콘, 디메티콘",
        "복부 팽만감, 불쾌감 개선",
        "제산제",
        "알루미늄, 마그네슘, 칼슘",
        "알칼리성으로 위산을 중화, 위산에 의한 위장 점막 손상을 예방"
      ]
    }
  ];

  final String topic;
  TipContentPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // Find the details corresponding to the given topic
    List<String>? details;
    String? subtitle;
    for (var item in content) {
      if (item['title'] == topic) {
        details = item['details'] as List<String>?;
        subtitle = item['subtitle'] as String?;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(topic, style: const TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (details != null) ...[
                Text(
                  subtitle!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 32.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: details.map((detail) {
                    return Column(
                      children: [
                        Text(
                          detail,
                          style: const TextStyle(fontSize: 18, height: 1.7),
                        ),
                        const SizedBox(height: 42.0)
                      ],
                    );
                  }).toList(),
                ),
              ] else ...[
                Text(
                  'No details found for $topic',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ],
              const SizedBox(height: 25.0),
              Container(
                  height: 1.0,
                  width: 350,
                  color: Color.fromARGB(255, 197, 196, 196)),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(350, 60),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '주제 목록으로 돌아가기',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
