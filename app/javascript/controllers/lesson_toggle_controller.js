import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() { return ["lessonType", 'videoLesson', "textLesson", "interactiveVideoLesson", 'typeField']; }

  toggle(e) {
    switch(e.target.value) {
      case 'text':
        this.typeFieldTarget.value = 'Text'
        this.textLessonTarget.classList.remove('d-none')
        this.videoLessonTarget.classList.add('d-none')
        this.interactiveVideoLessonTarget.classList.add('d-none')
        break;
      case 'video':
        this.typeFieldTarget.value = 'Video'
        this.textLessonTarget.classList.add('d-none')
        this.videoLessonTarget.classList.remove('d-none')
        this.interactiveVideoLessonTarget.classList.add('d-none')
        break;
      case 'interactive_video':
        this.typeFieldTarget.value = 'InteractiveVideo'
        this.textLessonTarget.classList.add('d-none')
        this.videoLessonTarget.classList.add('d-none')
        this.interactiveVideoLessonTarget.classList.remove('d-none')
        break;
    }
    document.querySelector("[role='group']").querySelector('.active').classList.remove('active')
    e.target.classList.add('active')
  }
}