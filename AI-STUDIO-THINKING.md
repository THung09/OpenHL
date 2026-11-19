# Google AI Studio Thinking matrix (OpenHL 2.12.0)

OpenHL only shows the Thinking control for the exact AI Studio model IDs below. It does not infer support from broad name patterns such as `Gemini`, `Pro`, or `Flash`.

## Gemini 4 — thinking levels

| Model ID | Supported levels | Google default |
|---|---|---|
| `gemini-4-argon` | Low, Medium, High | Medium |
| `gemini-4-carbon` | Low, Medium, High | Medium |
| `gemini-4-hydrogen` | Low, Medium, High, XHigh | High |

Gemini 4 does not support Minimal. The Hydrogen XHigh tier is specific to Hydrogen.

## Gemini 3 — thinking levels

| Model ID | Supported levels | Google default |
|---|---|---|
| `gemini-3.8-flash` | Low, Medium, High | Medium |
| `gemini-3.7-flash` | Low, Medium, High | Medium |
| `gemini-3.6-flash` | Minimal, Low, Medium, High | Medium |
| `gemini-3.5-flash-lite` | Minimal, Low, Medium, High | Minimal |
| `gemini-3.5-flash` | Minimal, Low, Medium, High | Medium |
| `gemini-3.1-pro-preview` | Low, Medium, High | High |
| `gemini-3.1-flash-lite` | Minimal, Low, Medium, High | Minimal |
| `gemini-3-flash-preview` | Minimal, Low, Medium, High | High |

## Image models with documented thinking levels

| Model ID | Supported levels | Google default |
|---|---|---|
| `gemini-nano-banana-2.1` | Minimal, Medium, High | Medium |
| `gemini-3.1-flash-lite-image` | Minimal, High | Minimal |
| `gemini-3.1-flash-image` | Minimal, High | Minimal |
| `gemini-3-pro-image` | High | High |

## Gemini 2.5 — thinking budgets, not thinking levels

These models use `thinking_budget`, so OpenHL shows token-budget choices rather than Low/Medium/High. `Auto` leaves the server's dynamic default unchanged.

| Model ID | Minimum | Maximum | Can disable thinking? |
|---|---:|---:|---|
| `gemini-2.5-pro` | 128 | 32,768 | No |
| `gemini-2.5-flash` | 1 | 24,576 | Yes, budget `0` |
| `gemini-2.5-flash-lite` | 512 | 24,576 | Yes, budget `0` |

The budget choices shown by OpenHL stay within the published model-specific limits. A budget of `0` is only offered on Flash and Flash-Lite.

## Models intentionally excluded

Model IDs without documented thinking support do not get a Thinking control. Examples include `gemma-4-31b-it`, `gemini-decision-1`, `gemini-3.8-flash-tts`, and `gemini-3.5-transcribe`. Unknown or newly released IDs are also hidden until their support and request format are verified.

## Request mapping

- Gemini 3/4 levels: OpenHL sends `reasoning_effort` with the model's allowed level.
- Gemini 2.5 budgets: OpenHL sends `google.thinking_config.thinking_budget` through the AIStudio2API OpenAI-compatible endpoint.
- AI Studio's `-latest` aliases and `models/` prefix are normalized to the base model ID for capability lookup.

## Sources

- Google, [Thinking models and supported levels / budgets](https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/thinking)
- Google, [Introducing Gemini 4 Hydrogen](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-Hydrogen/)
- AIStudio2API, [model catalog](https://github.com/Mag1cFall/AIStudio2API/blob/main/README_en.md#models)
- AIStudio2API, [protocol and thinking parameter mapping](https://github.com/Mag1cFall/AIStudio2API/blob/main/docs/protocol.md)
