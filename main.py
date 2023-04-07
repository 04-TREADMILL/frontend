import hashlib
import os
import subprocess
import urllib.request
from typing import List

import streamlit as st

file_url = 'https://senti-strength.oss-cn-nanjing.aliyuncs.com/myEASIEST-1.0-SNAPSHOT.jar'
file_name = 'myEASIEST-1.0-SNAPSHOT.jar'


def fetch() -> str:
    os.remove(file_name)
    urllib.request.urlretrieve(file_url, file_name)
    with open(file_name, 'rb') as f:
        md5 = hashlib.md5(f.read()).hexdigest()
    return md5


def cmd(text: str, option: str, explain: bool) -> List[str]:
    res = ["java", "-jar", "myEASIEST-1.0-SNAPSHOT.jar", "text", text, option, ]
    if explain:
        res.append("explain")
    return res


def run(cmd: List[str]) -> str:
    result = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
    return result.stdout.decode('utf-8')


if __name__ == "__main__":
    st.set_page_config(page_title="Senti Strength")
    st.title("Senti Strength")
    if st.button("Update JAR"):
        st.info(f"Update successfully with latest MD5 **{fetch()}**")
    st.write("---")
    text = st.text_input(label="Enter text 👇")
    option = st.radio(
        "Set options 👇",
        ('trinary', 'binary', 'scale'))
    explain = st.checkbox('Explain')
    if st.button("Detect Sentiment"):
        if len(text) == 0:
            st.error("No input text")
        else:
            st.success(f"**Result:** {run(cmd(text, option, explain))}")
