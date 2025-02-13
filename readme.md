## AIHub, 모두의말뭉치 전처리

필터링, dedup 수행

사용되는 dataset은 datasets.md를 참고하세요. 전처리 후 `corpus`만을 남긴다면 16,056,320행 89.9GiB의 데이터를 얻을 것으로 기대됩니다.

- Kotlin Notebook과 dataframe을 사용해 기본적인 전처리 수행 -> jsonl (processing.ipynb)
- Python을 사용해 jsonl 파일을 읽어들여 exact dedup, email delete, length_filter(100자 이상, 5문장 이상) 수행 (dataset_dedup.ipynb)
- minhash dedup (from [ChenghaoMou/text-dedup](https://github.com/ChenghaoMou/text-dedup)) 수행 (dataset_dedup.ipynb, dedup_by_cluster.sh)

### 라이선스
MIT License 💕