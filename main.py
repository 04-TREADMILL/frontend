import subprocess
from typing import List

import streamlit as st


def cmd(text: str) -> List[str]:
    return ["java", "-jar", "myEASIEST-1.0-SNAPSHOT.jar", "text", text, "explain"]


def fn(text: str) -> str:
    result = subprocess.run(cmd(text), stdout=subprocess.PIPE, check=True)
    return result.stdout.decode('utf-8')


if __name__ == "__main__":
    st.title("SentiStrength")
    user_input = st.text_input(label="Enter text:")
    if st.button("Detect Sentiment"):
        st.write(f"Result: {fn(user_input)}")
